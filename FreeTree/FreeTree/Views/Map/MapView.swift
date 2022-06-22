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
    @State private var region = MKCoordinateRegion(
        center: LocationManager.shared.locationCoordinate?.coordinate ?? LocationManager.shared.defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var body: some View {
        VStack {
            PolylineMapView(
                region: $region
            )
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                locationManager.requestLocation()
            }.onReceive(locationManager.$locationCoordinate, perform: { _ in
                if let coordinate = locationManager.locationCoordinate?.coordinate {
                    region.center = coordinate
                }
            })
            if !locationManager.isLocationAuthorized() {
                // TODO: Débito técnico -> design para Localização não autorizada
                Text("You haven't shared your location")
                Text("Please allow in Settings")
            }
        }
    }
}
