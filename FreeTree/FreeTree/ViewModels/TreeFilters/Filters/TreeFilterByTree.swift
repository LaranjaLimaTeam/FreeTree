//
//  TreeFilterOnRoute.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 13/07/22.
//

import Foundation

class TreeFilterByTree: TreeFilter {
    let tree: Tree
    init(tree: Tree) {
        self.tree = tree
    }
    func filter(tree: Tree) -> Bool {
        return tree == self.tree
    }
}
