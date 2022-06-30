//
//  TreeManager.swift
//  FreeTree
//
//  Created by Pedro Mota on 21/06/22.
//

import Foundation

class TreeRepository: TreeDAO {
    
    @Published var trees: [Tree] = []
    
    var treesPublished: Published<[Tree]>.Publisher { $trees }
    
    private let jsonManager: JsonManager
    
    init() {
        self.jsonManager = JsonManager()
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
        let result = jsonManager.saveJson(data: tree, fileName: JsonManager.defaultJson)
    
        if let result = result {
            self.trees = self.trees.filter {
                return !($0 == tree)
            }
            trees.append(tree)
            completion(.success(result))
        } else {
            completion(.failure(.creationError))
        }
    }
    public func fetch(completion: @escaping (Result<[Tree], TreeManagerError>) -> Void) {
        let result: [Tree]? = jsonManager.decodingJson(fileName: JsonManager.defaultJson)
        if let result = result {
            completion(.success(result))
        } else {
            completion(.failure(.fetchError))
        }
    }
    
}
