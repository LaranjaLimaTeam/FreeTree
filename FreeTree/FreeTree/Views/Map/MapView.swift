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
    let notificationRoutePublisher = NotificationCenter.default.publisher(for: NSNotification.Name("endRoute"))
    let notificationTreeFilterPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("treeFilters"))
    
    var body: some View {
        if mapViewModel.selectingPosition {
            TestMapView(mapViewModel: mapViewModel)
                .onDisappear {
                    mapViewModel.updateFilter(filterType: mapViewModel.currentFilterEnum)
                }
        } else {
            ZStack {
                VStack {
                    PolylineMapView()
                        .edgesIgnoringSafeArea(.top)
                        .onAppear {
                            mapViewModel.requestLocation()
                        }
                        .alert(isPresented: $showingRouteAlert) {
                            Alert(title: Text("Você chegou ao seu destino!"),
                                  message: Text("Aproveite o seu momento com a natureza :-)"),
                                  dismissButton: .default(Text("OK")))
                        }
                        .environmentObject(mapViewModel)
                        .overlay {
                            VStack {
                                Spacer()
                                if mapViewModel.routeViewModel.destination == nil {
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
                    if !mapViewModel.isLocationAuthorized() {
                        // TODO: Débito técnico -> design para Localização não autorizada
                        ErrorMessage()
                    }
                    
                }
                .sheet(isPresented: $mapViewModel.showAddTreeSheet) {
                    if let safeCoordinate = mapViewModel.currentCenterLocation {
                        AddTreeView(treeCoordinate: safeCoordinate,
                                    isPresented: $mapViewModel.showAddTreeSheet
                        )
                    }
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
            .onReceive(notificationTreeFilterPublisher) { _ in
            }
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
