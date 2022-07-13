//
//  TreeFilterFactory.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 13/07/22.
//

import Foundation

class TreeFilterFactory{
    func create(type: TreeFilterTypes) -> TreeFilter {
            switch type {
            case .fruitful:
                return TreeFilterFruitful()
            case .personal(let user):
                return TreeFilterPersonal(user: user)
            case .all:
                return TreeFilterAll()
            case .onRoute(let tree):
                return TreeFilterOnRoute(tree: tree)
            case .random:
                return TreeFilterRandom()
            }
        }
}
