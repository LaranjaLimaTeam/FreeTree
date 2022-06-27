//
//  TreeManager.swift
//  FreeTree
//
//  Created by Pedro Mota on 21/06/22.
//

import Foundation

class JSONTreeManager: TreeManager {
    
    private let jsonManager: JsonManager
    
    init() {
        self.jsonManager = JsonManager()
    }
    
    public func create(_ tree: Tree, completion: @escaping (Result<Tree, TreeManagerError>) -> Void) {
        let result = JsonManager.saveJson(data: tree)
        
        if let result = result {
            completion(.success(result))
        } else {
            completion(.failure(.creationError))
        }
    }
    public func fetch(completion: @escaping (Result<[Tree], TreeManagerError>) -> Void) {
        let result: [Tree]? = JsonManager.decoding(fileName: "myJsonData")
        if let result = result {
            completion(.success(result))
        } else {
            completion(.failure(.fetchError))
        }
    }
    
}
