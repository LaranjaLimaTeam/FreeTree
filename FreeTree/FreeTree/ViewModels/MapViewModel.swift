//
//  MapViewModel.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 22/06/22.
//

import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    var locationManager = LocationManager.shared
    
    @Published var trees:[Tree] = []
    @Published var hasToCentrilize:Bool = false
    @Published var region = MKCoordinateRegion(
        center: LocationManager.shared.locationCoordinate?.coordinate ?? LocationManager.shared.defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    func updateTrees(){
        let latRand = Double.random(in: -0.05 ..< 0.05)
        let lonRand = Double.random(in: -0.05 ..< 0.05)
        //DEBUG
        if (trees.count<10){
            trees.append(Tree(name: String(trees.count), address:
                                Address(street: "", number: 0, neighborHood: "", city: "", stateOrProvince: "", zipCode: ""),
                              coordinates: Coordinate(latitude: 37.334803+latRand, longitude: -122.008965 + lonRand)))
        }
    }
    func centralizeMapRegion(){
        hasToCentrilize = true
    }
    func requestLocation(){
        locationManager.requestLocation(completion: {
            guard let location = self.locationManager.locationCoordinate else { return }
            OperationQueue.main.addOperation {
                self.region.center = location.coordinate
                self.centralizeMapRegion()
            }
        })
    }

}
