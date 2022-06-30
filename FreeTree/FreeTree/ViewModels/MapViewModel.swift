//
//  MapViewModel.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 22/06/22.
//

import MapKit
import SwiftUI
import Combine

class MapViewModel: ObservableObject {
    @Published private(set) var treesOnMap: [Tree] = []
    @Published var hasToCentrilize: Bool = false
    @Published var showAddTreeSheet: Bool = false
    @Published var showTreeProfile: Bool = false
    @Published var selectedTree: Tree?
    @Published var region = MKCoordinateRegion(
        center: LocationManager.shared.locationCoordinate?.coordinate ?? LocationManager.shared.defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    private let locationManager = LocationManager.shared
    private let treeManager = TreeManagerImplementation.shared
    var cancellable: Cancellable?
    
    init() {
        cancellable = self.treeManager.$trees
            // TODO: Implement filters from contextual menu
            .filter({ _ in
                return true
            })
            .sink(receiveValue: { treeArray in
                self.treesOnMap = treeArray
            })
    }

    func showAddTreeModal() {
        self.showAddTreeSheet.toggle()
    }
    
    func centralizeMapRegion() {
        if let location = self.locationManager.locationCoordinate {
            self.region.center = location.coordinate
        }
        hasToCentrilize = true
    }

    func requestLocation() {
        locationManager.requestLocation(completion: {
            guard let location = self.locationManager.locationCoordinate else { return }
            OperationQueue.main.addOperation {
                self.region.center = location.coordinate
                self.centralizeMapRegion()
            }
        })
    }
    func isLocationAuthorized() -> Bool {
        return locationManager.isLocationAuthorized()
    }
    
}
