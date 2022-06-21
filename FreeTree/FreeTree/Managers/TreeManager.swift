//
//  TreeManager.swift
//  FreeTree
//
//  Created by Pedro Mota on 21/06/22.
//

import Foundation

protocol TreeManager {
    func create(_ tree: Tree, completion: @escaping (Result<Tree, Error>) -> Void)
}
