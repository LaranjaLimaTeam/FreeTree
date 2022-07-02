//
//  FireBaseTreeRepository.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 02/07/22.
//

import Foundation

class FireBaseTreeRepository: TreeDAO {
    
    @Published var trees: [Tree] = []
    
    var treesPublished: Published<[Tree]>.Publisher { $trees }
    
    private let fireBaseManager: FireBaseManager
    
    init() {
        self.fireBaseManager = FireBaseManager()
        fetch(completion: { result in
            switch result {
            case .success(let trees):
                self.trees = trees
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    public func create(_ tree: Tree, completion: @escaping (Result<Tree, TreeManagerError>) -> Void) {
        let result = fireBaseManager.addData(data: tree, collection: FireBaseManager.treesCollection)
    
        if let result = result {
            trees.append(tree)
            completion(.success(result))
        } else {
            completion(.failure(.creationError))
        }
    }
    public func fetch(completion: @escaping (Result<[Tree], TreeManagerError>) -> Void) {
        fireBaseManager.getData(collection: FireBaseManager.treesCollection) { (result: [Tree]?) in
            if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(.fetchError))
            }
        }
       
    }
    
}
