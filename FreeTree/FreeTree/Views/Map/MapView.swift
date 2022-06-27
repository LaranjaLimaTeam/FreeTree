//
//  MapView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 21/06/22.
//
import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var locationManager = LocationManager.shared
    @StateObject var mapViewModel = MapViewModel()

    var body: some View {
        VStack {
            PolylineMapView()
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                mapViewModel.requestLocation()
            }
            .environmentObject(mapViewModel)
            if !locationManager.isLocationAuthorized() {
                // TODO: Débito técnico -> design para Localização não autorizada
                Text("You haven't shared your location")
                Text("Please allow in Settings")
            }
        }
    }


}
