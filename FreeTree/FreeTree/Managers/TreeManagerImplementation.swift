//
//  TreeManagerImplementation.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 29/06/22.
//

import Foundation
import Combine

class TreeManagerImplementation {
    
    @Published var trees: [Tree] = []
    static let shared = TreeManagerImplementation()
    let treeRepository: TreeDAO
    var cancellable: Cancellable?
    
    init(treeRepository: FireBaseTreeRepository = FireBaseTreeRepository()) {
        self.treeRepository = treeRepository
        cancellable = self.treeRepository.treesPublished
            .sink(receiveValue: { treeArray in
                self.trees = treeArray
            })
    }
    
    func addTree(tree: Tree, completion: @escaping (Result<Tree, TreeManagerError>) -> Void ) {
        self.treeRepository.create(tree) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let newTree):
                strongSelf.trees.append(newTree)
                completion(.success(newTree))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func updateTrees(completion: @escaping (Result<Bool, TreeManagerError>) -> Void) {
        self.treeRepository.fetch(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let newTrees):
                strongSelf.trees = newTrees
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    }
}
