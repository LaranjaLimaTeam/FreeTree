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

    var body: some View {
        ZStack {
            VStack {
                PolylineMapView()
                .edgesIgnoringSafeArea(.vertical)
                .onAppear {
                    mapViewModel.requestLocation()
                }
                .environmentObject(mapViewModel)
                if !mapViewModel.isLocationAuthorized() {
                    // TODO: Débito técnico -> design para Localização não autorizada
                    Text("You haven't shared your location")
                    Text("Please allow in Settings")
                }
            }
            BottomSheet(isPresented: $mapViewModel.showAddTreeSheet) {
                Color.init(uiColor: .systemGray5)
                AddTreeView(
                    isPresented: $mapViewModel.showAddTreeSheet
                )
            }
            HStack {
                Spacer()
                MapButtonStack()
                    .environmentObject(mapViewModel)
                    .padding()
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
