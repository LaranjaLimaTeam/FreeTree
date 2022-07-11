//
//  PolylineMapViewCoordinator.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 23/06/22.
//
import SwiftUI
import MapKit

final class PolylineMapViewCoordinator: NSObject, MKMapViewDelegate {
    private let map: PolylineMapView
    init(_ control: PolylineMapView) {
        self.map = control
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: false)
        if view.reuseIdentifier != "tree" { return }
        let treeArray = map.mapViewModel.treesOnMap
        let tree = treeArray.filter {
            if let subtitle = view.annotation?.subtitle {
               return "\($0.id)" == subtitle
            }
            return false
        }
        if  let tree = tree.first {
            map.mapViewModel.selectedTree = tree
            
            // DEBUG: apenas para debugar enquanto não existe o botão de rota
            map.mapViewModel.startRoute(destination: tree.coordinates)
        }
        map.mapViewModel.showTreeProfile.toggle()
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.blue
         renderer.lineWidth = 3.0
         return renderer
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return usetPin(annotation: annotation)
        }
        return treePin(annotation: annotation)
    }
    func usetPin(annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
    func treePin(annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "tree")
        view.image =  UIImage(named: "tree-placemark")
        view.frame.size = CGSize(width: 50, height: 50)
        return view
    }
}
