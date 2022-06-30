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

    private let treeManager: TreeManagerImplementation

    init() {
        self.treeManager = TreeManagerImplementation.shared
    }
    
    public func addTree() {
        self.treeManager.addTree(tree: tree, completion: { result in
            switch result {
            case .success:
                print("Tree added with success")
            case . failure(_):
                print("error on add a tree")
            }
        })
    }
}
