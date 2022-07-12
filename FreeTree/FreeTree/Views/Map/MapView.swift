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

    var body: some View {
        ZStack {
            VStack {
                PolylineMapView()
                .edgesIgnoringSafeArea(.top)
                .onAppear {
                    mapViewModel.requestLocation()
                }
                .environmentObject(mapViewModel)
                .overlay {
                    VStack {
                        Spacer()
                        BottomSearchView(
                            isSearching: $isSearching,
                            mapViewModel: mapViewModel,
                            trees: mapViewModel.treesOnMap)
                        
                    }
                }
                if !mapViewModel.isLocationAuthorized() {
                    // TODO: Débito técnico -> design para Localização não autorizada
                    ErrorMessage()
                }
                
            }
            BottomSheet(isPresented: $mapViewModel.showAddTreeSheet) {
                Color.init(uiColor: .systemGray5)
                AddTreeView(
                    isPresented: $mapViewModel.showAddTreeSheet
                )
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
                TreeProfileView(
                    presentationMode: $presentationMode,
                    treeViewModel: TreeProfileViewModel(tree: mapViewModel.selectedTree!)
                )
            }, presentationMode: $presentationMode)
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
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}
