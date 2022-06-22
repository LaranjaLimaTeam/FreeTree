//
//  PolylineMapView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 21/06/22.
//
import SwiftUI
import MapKit

struct PolylineMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    func makeCoordinator() -> PolylineMapViewCoordinator {
        PolylineMapViewCoordinator(self)
    }
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        mapView.region = region
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<PolylineMapView>) {
        uiView.setRegion(region, animated: true)
    }
}

final class PolylineMapViewCoordinator: NSObject, MKMapViewDelegate {
    private let map: PolylineMapView
    init(_ control: PolylineMapView) {
        self.map = control
    }
}
