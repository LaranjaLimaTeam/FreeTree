//
//  AddTreeViewModel.swift
//  FreeTree
//
//  Created by Pedro Mota on 22/06/22.
//

import Foundation
import SwiftUI

class AddTreeViewModel: ObservableObject {
    @ObservedObject private var locationManager: LocationManager
    @Published var tree = Tree()
    private let treeManager: TreeManagerImplementation
    
    init() {
        self.treeManager = TreeManagerImplementation.shared
        self.locationManager = LocationManager.shared
    }
    
    public func addTree() {
        self.tree.coordinates = getTreeCoordinate()
        
        self.treeManager.addTree(tree: tree) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                print("Tree added with success")
            case . failure(_):
                print("error on add a tree")
            }
        }
    }
                                 
    private func getTreeCoordinate() -> Coordinate {
            guard let currentCoordinate = locationManager.locationCoordinate else {
                return Coordinate()
            }
            return currentCoordinate
    }
                                 
}
