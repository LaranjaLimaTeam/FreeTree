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

    private let treeManager: TreeManager

    init() {
        self.treeManager = JSONTreeManager()
    }
    
    public func addTree() {
        self.treeManager.create(self.tree) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(_):
                print("success")
            case .failure(_):
                print("error")
            }
        }
    }
}
