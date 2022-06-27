//
//  MapViewModel.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 22/06/22.
//

import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published private(set) var trees: [Tree] = []
    @Published var hasToCentrilize: Bool = false
    @Published var region = MKCoordinateRegion(
        center: LocationManager.shared.locationCoordinate?.coordinate ?? LocationManager.shared.defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var locationManager = LocationManager.shared
    let treeManager: TreeManager
    
    init(treeManager: TreeManager = JSONTreeManager()) {
        self.treeManager = treeManager
        self.fetchTrees()
    }
    
    func addTrees(_ newTrees: [Tree]) {
        self.trees.append(contentsOf: newTrees)
    }
    func removeTree(tree: Tree) {
        self.trees = trees.filter {
            $0.coordinates.latitude != tree.coordinates.latitude &&
            $0.coordinates.longitude != tree.coordinates.longitude &&
            $0.name != tree.name
        }
    }
    
    func centralizeMapRegion() {
        hasToCentrilize = true
    }
    func fetchTrees() {
        treeManager.fetch(completion: {  [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let loadedTrees):
                strongSelf.addTrees(loadedTrees)
            case .failure(let error):
                print(error)
            }
        })
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
    
}
