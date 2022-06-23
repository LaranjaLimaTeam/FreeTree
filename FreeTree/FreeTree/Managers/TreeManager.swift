//
//  TreeManager.swift
//  FreeTree
//
//  Created by Pedro Mota on 22/06/22.
//

import Foundation

protocol TreeManager {
    func create(_ tree: Tree, completion: @escaping (Result<Tree, TreeManagerError>) -> Void)
}

enum TreeManagerError: Error {
    case creationError
}
