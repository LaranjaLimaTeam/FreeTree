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
    @Published var photos = [UIImage]()
    
    
    private let treeManager: TreeManagerImplementation
    private let photoRepository: PhotoRepository
    
    init() {
        self.locationManager = LocationManager.shared
        self.treeManager = TreeManagerImplementation.shared
        self.photoRepository = FirebasePhotoRepository()
    }
    
    private func addPhtos(to treeId: String) {
        for photo in photos {
            if let data = photo.jpeg(.low) {
                self.photoRepository.add(treeId, data) { [weak self] result in
                    guard let strongSelf = self else { return }
                    
                    switch result {
                    case .success:
                        print("Added photo with sucess")
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    public func addTree() {
        //self.tree.coordinates = getTreeCoordinate()
        
        self.treeManager.addTree(tree: tree) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let tree):
                if let treeId = tree.id {
                    strongSelf.addPhtos(to: treeId)
                }
            case .failure:
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
    
    func fetchAddress(coordinate: Coordinate) {
        self.tree.coordinates = coordinate
        locationManager.getAddress(coordinate: coordinate) { address in
            if let safeAddress = address {
                self.tree.address = safeAddress
            }
        }
    }
                                 
}
