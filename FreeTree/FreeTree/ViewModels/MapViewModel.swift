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
    var trees: [Tree] = []
    @Published var hasToCentrilize: Bool = false
    @Published var showAddTreeSheet: Bool = false
    @Published var showTreeProfile: Bool = false
    @Published var selectedTree: Tree?
    @Published var hasToUpdateRoute: Bool = false
    @Published var region = MKCoordinateRegion(
        center: LocationManager.shared.locationCoordinate?.coordinate ?? LocationManager.shared.defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @Published var selectingPosition: Bool = false
    
    var currentCenterLocation: Coordinate?
    
    private let locationManager = LocationManager.shared
    private let treeManager = TreeManagerImplementation.shared
    let treeFilterFactory = TreeFilterFactory()
    var currentFilterEnum: TreeFilterTypes
    var currentFilter: TreeFilter
    var routeViewModel = RouteViewModel()
    var cancellable: Cancellable?
    var cancellableRoute: Cancellable?
    
    init() {
        self.currentFilterEnum = .all
        self.currentFilter = treeFilterFactory.create(type: currentFilterEnum)
        cancellable = self.treeManager.$trees
            .map({ trees in
                self.trees = trees
                return trees.filter { tree in
                    self.currentFilter.filter(tree: tree)
                }
            })
            .sink(receiveValue: { treeArray in
                self.treesOnMap = treeArray
            })
        cancellableRoute = self.routeViewModel.$route
            .sink(receiveValue: { _ in
                self.hasToUpdateRoute = true
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
    func startRoute(_ destination: Coordinate) {
        hasToUpdateRoute = true
        routeViewModel.destination = destination
    }
    func stopRoute() {
        routeViewModel.endRoute()
        hasToUpdateRoute = true
    }
    
    func calculateDistance(tree: Tree) -> Double {
        let coordinate = tree.coordinates
        guard let distanceInMeters = locationManager.getDistance(coordinates: coordinate) else {return 0}
        let distanceInKm: Double = distanceInMeters*1.0/1000
        return distanceInKm
    }
    func updateFilter(filterType: TreeFilterTypes) {
        self.currentFilterEnum = filterType
        self.currentFilter = treeFilterFactory.create(type: filterType)
        treesOnMap = self.trees.filter({ tree in
            currentFilter.filter(tree: tree)
        })
    }
    
    func cleanTreesOnMap() {
        self.treesOnMap = []
    }
    
    func setCenterCoordinate(coordinate: Coordinate) {
        self.currentCenterLocation = coordinate
    }
    
    func verifyAvailableDistance() -> Bool {
        if let safeCoordinate = self.currentCenterLocation {
            let distance = locationManager.getDistance(coordinates: safeCoordinate)
            guard let safeDistance = distance else { return false }
            print(safeDistance)
            return safeDistance <= 50 ? true : false
        }
        return false
    }
}
