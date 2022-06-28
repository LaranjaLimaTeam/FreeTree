//
//  PolylineMapView.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 21/06/22.
//
import SwiftUI
import MapKit
import os.log

struct PolylineMapView: UIViewRepresentable {
    @EnvironmentObject var mapViewModel: MapViewModel
    
    func makeCoordinator() -> PolylineMapViewCoordinator {
        PolylineMapViewCoordinator(self)
    }
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        mapView.region = mapViewModel.region
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<PolylineMapView>) {
        os_log("Updating map", log: .default, type: .debug)
        
        if mapViewModel.hasToCentrilize {
            uiView.setRegion(mapViewModel.region, animated: true)
            mapViewModel.hasToCentrilize = false
        }
        if mapViewModel.trees.count != uiView.annotations.count-1 {
            uiView.removeAnnotations(uiView.annotations)
            mapViewModel.trees.forEach({ tree in
                let annotationTree = MKPointAnnotation()
                annotationTree.title = tree.name
                annotationTree.coordinate = tree.coordinates.coordinate
                uiView.addAnnotation(annotationTree)
            })
        }
    }
}
