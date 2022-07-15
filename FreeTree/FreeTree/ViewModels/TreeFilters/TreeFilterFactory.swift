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
            case .onlyFruitful:
                return TreeFilterFruitful()
            case .byUser(let user):
                return TreeFilterByUser(user: user)
            case .all:
                return TreeFilterAll()
            case .byTree(let tree):
                return TreeFilterByTree(tree: tree)
            case .random:
                return TreeFilterRandom()
             case .none:
                return TreeFilterNone()
        }
    }
}
