//
//  MapView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 21/06/22.
//
import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var mapViewModel = MapViewModel()
    @State var presentationMode: UISheetPresentationController.Detent.Identifier = .medium
    @State var isSearching: Bool = false
    @State var showingRouteAlert: Bool = false
    @State var showingRouteErrorAlert: Bool = false
    @State var loadingRoute: Bool = false
    let notificationRoutePublisher = NotificationCenter.default.publisher(for: NSNotification.Name("endRoute"))
    let notificationRouteErrorPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("routeError"))
    
    var body: some View {
        ZStack {
            VStack {
                PolylineMapView()
                    .edgesIgnoringSafeArea( mapViewModel.selectingPosition ? .vertical : .top)
                    .onAppear {
                        mapViewModel.requestLocation()
                    }
                    .alert(isPresented: $showingRouteAlert) {
                        Alert(title: Text("Você chegou ao seu destino!"),
                              message: Text("Aproveite o seu momento com a natureza :-)"),
                              dismissButton: .default(Text("OK")))
                    }
                    .alert(isPresented: $showingRouteErrorAlert) {
                        Alert(title: Text("Erro ao calcular a rota"),
                              message: Text("Não conseguimos calcular a rota até essa árvore."),
                              dismissButton: .default(
                                Text("OK"),
                                action: {
                                    self.mapViewModel.stopRoute()
                                }
                              )
                              
                        )
                    }
                    .environmentObject(mapViewModel)
                    .overlay {
                        if mapViewModel.selectingPosition {
                            SelectingPositionOnMap(mapViewModel: mapViewModel)
                        } else {
                            VStack {
                                Spacer()
                                if mapViewModel.routeViewModel.destination == nil  {
                                    BottomSearchView(
                                        isSearching: $isSearching,
                                        mapViewModel: mapViewModel,
                                        trees: mapViewModel.treesOnMap)
                                } else {
                                    OnRouteView(
                                        stopRoute: self.mapViewModel.stopRoute,
                                        treeTitle: mapViewModel.selectedTree?.name ?? "Arvore",
                                        routeViewModel: mapViewModel.routeViewModel
                                    )
                                }
                            }
                        }
                    }
                if !mapViewModel.isLocationAuthorized() {
                    // TODO: Débito técnico -> design para Localização não autorizada
                    ErrorMessage()
                }
            }
            .blur(radius: loadingRoute ? 30 : 0)
            .sheet(isPresented: $mapViewModel.showAddTreeSheet) {
                if let safeCoordinate = mapViewModel.currentCenterLocation {
                    AddTreeView(treeCoordinate: safeCoordinate,
                                isPresented: $mapViewModel.showAddTreeSheet
                    )
                    .onDisappear {
                        mapViewModel.updateFilter(filterType: mapViewModel.currentFilterEnum)
                        mapViewModel.updateSpan(zoom: 0.01)
                    }
                }
            }
            if loadingRoute {
                LoadingView(label: "Calculando a rota..")
            }
            if !isSearching {
                HStack {
                    Spacer()
                    MapButtonStack()
                        .environmentObject(mapViewModel)
                        .padding()
                }
            }
        }
        .onReceive(self.mapViewModel.routeViewModel.$isFetchingRoute) { resp in
            loadingRoute = resp
        }
        .sheet(isPresented: $mapViewModel.showTreeProfile) {
            HalfSheet(content: {
                TreeProfileView(treeViewModel: TreeProfileViewModel(tree: mapViewModel.selectedTree!),
                                presentationMode: $presentationMode,
                                startRoute: {
                    if let tree = mapViewModel.selectedTree {
                        self.mapViewModel.startRoute(tree.coordinates)
                    }
                }
                )
            }, presentationMode: $presentationMode)
        }
        .onReceive(notificationRoutePublisher) { _ in
            showingRouteAlert = true
        }
        .onReceive(notificationRouteErrorPublisher) { _ in
            showingRouteErrorAlert = true
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct ErrorMessage: View {
    var body: some View {
        VStack {
            Text("You haven't shared your location")
            Text("Please allow in Settings")
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
