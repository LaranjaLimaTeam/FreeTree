//
//  RouteViewModel.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 07/07/22.
//

import Foundation
import MapKit
import Combine

class RouteViewModel: ObservableObject {
    private let locationManager: LocationManager
    private let distanceThreshold: Double = 10.0 // metros
    
    var currentUserLocation: Coordinate?
    var currentPolylineLocation: Coordinate?
    var cancellable: Cancellable?
    var destination: Coordinate?
    @Published var route: MKPolyline?
    @Published var routeDistance: Double?
    
    init () {
        self.locationManager = LocationManager.shared
        cancellable = self.locationManager.$locationCoordinate
            .sink(receiveValue: { location in
                guard let location = location else { return }
                self.currentUserLocation = location
                self.updatePolyline()
            })
    }
    
    func updatePolyline() {
        guard let destination = destination else { return }
        guard let currentUserLocation = self.currentUserLocation else { return }
        guard let currentPolylineLocation = self.currentPolylineLocation else {
            getRoutePolyline()
            return
        }
        
        let user = locationManager.createCLLocation(coordinate: currentUserLocation)
        let poly = locationManager.createCLLocation(coordinate: currentPolylineLocation)
        let dest = locationManager.createCLLocation(coordinate: destination)
        
        if dest.distance(from: user) < distanceThreshold {
            endRoute()
            let notificationName = Notification.Name("endRoute")
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        
        if user.distance(from: poly) > distanceThreshold {
            getRoutePolyline()
        }
        
    }
    
    func getRoutePolyline() {
        guard let destination = destination else { return }
        guard let currentUserLocation = self.currentUserLocation else { return }
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentUserLocation.coordinate,
                                                          addressDictionary: nil))
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination.coordinate,
                                                               addressDictionary: nil))
        request.transportType = .walking
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print(error)
                return
            }
            guard let unwrappedResponse = response else { return }
            guard let firstRoute = unwrappedResponse.routes.first else { return }
            if self.destination != nil {
                self.routeDistance = firstRoute.distance
                self.route = firstRoute.polyline
                self.currentPolylineLocation = currentUserLocation
            }
        }
    }
    
    func endRoute() {
        self.route = nil
        self.destination = nil
        self.currentPolylineLocation = nil
        self.routeDistance = nil
    }
}
