//
//  AddTreeViewModel.swift
//  FreeTree
//
//  Created by Pedro Mota on 22/06/22.
//

import Foundation
import SwiftUI

class AddTreeViewModel: ObservableObject {

    @Published var tree = Tree()
    @ObservedObject private var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    
    private let treeManager: TreeManager

    init() {
        self.treeManager = JSONTreeManager()
        self.locationManager = LocationManager.shared
    }
    
    private func getTreeCoordinate() -> Coordinate {
        guard let currentCoordinate = locationManager.locationCoordinate else {
            return Coordinate()
        }
        return currentCoordinate
    }
    
    public func addTree() {
        self.tree.coordinates = getTreeCoordinate()
        
        self.treeManager.create(self.tree) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                print("success")
            case .failure:
                print("error")
            }
        }
    }
}
