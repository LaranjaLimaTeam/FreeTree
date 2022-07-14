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
    @State var showingTreeFiltersAlert: Bool = false
    let notificationRoutePublisher = NotificationCenter.default.publisher(for: NSNotification.Name("endRoute"))
    let notificationTreeFilterPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("treeFilters"))
    
    var body: some View {
        ZStack {
            VStack {
                PolylineMapView()
                    .edgesIgnoringSafeArea(.top)
                    .onAppear {
                        mapViewModel.requestLocation()
                    }
                    .alert(isPresented: $showingTreeFiltersAlert) {
                        Alert(title: Text("Você chegou ao seu destino!"),
                              message: Text("Aproveite o seu momento com a natureza :-)"),
                              dismissButton: .default(Text("OK")))
                    }
                    .alert(isPresented: $showingRouteAlert) {
                        Alert(title: Text("Você chegou ao seu destino!"),
                              message: Text("Aproveite o seu momento com a natureza :-)"),
                              dismissButton: .default(Text("OK")))
                    }
                    .environmentObject(mapViewModel)
                    .overlay {
                        if mapViewModel.selectingPosition {
                            BackgroundAddingTree(mapViewModel: mapViewModel)
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


struct BackgroundAddingTree: View {
    @ObservedObject var mapViewModel: MapViewModel
    @State var distanceError = false
    var body: some View {
        if mapViewModel.selectingPosition == true {
            ZStack(alignment: .center) {
                Image("tree-placemark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            print("Cancelei arvore")
                            mapViewModel.currentCenterLocation = nil
                            mapViewModel.selectingPosition = false
                        } label: {
                            Text("Cancelar")
                        }
                        
                        Button {
                            print("To pegando localizaçao")
                            print(mapViewModel.currentCenterLocation)
                            let result = mapViewModel.verifyAvailableDistance()
                            if result {
                                mapViewModel.selectingPosition = false
                                mapViewModel.showAddTreeSheet.toggle()
                            } else {
                                self.distanceError = true
                                print("Erro")
                            }
                        } label: {
                            Text("Choose Spot")
                        }
                        
                    }
                }
            }
            .alert("Erro ao selecionar posição", isPresented: $distanceError) {
                Button("Ok", role: .destructive) {
                    self.distanceError = false
                }
            }
        } else {
            EmptyView()
        }
    }
}
