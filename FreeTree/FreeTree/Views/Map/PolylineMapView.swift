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
        if mapViewModel.hasToCentrilize {
            uiView.setRegion(mapViewModel.region, animated: true)
            mapViewModel.hasToCentrilize = false
        }
        if mapViewModel.treesOnMap.count != uiView.annotations.count-1 {
            uiView.removeAnnotations(uiView.annotations)
            mapViewModel.treesOnMap.forEach({ tree in
                let annotationTree = MKPointAnnotation()
                annotationTree.title = tree.name
                annotationTree.coordinate = tree.coordinates.coordinate
                annotationTree.subtitle = "\(tree.id)"
                uiView.addAnnotation(annotationTree)
            })
        }
        
        if mapViewModel.hasToUpdateRoute {
            mapViewModel.hasToUpdateRoute = false
            uiView.removeOverlays(uiView.overlays)
            if let route = mapViewModel.routeViewManager.route {
                uiView.addOverlay(route)
            }
        }
        
    }
}
