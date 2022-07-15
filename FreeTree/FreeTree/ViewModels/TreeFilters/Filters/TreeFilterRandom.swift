//
//  TreeFilterRandom.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 13/07/22.
//

import Foundation

class TreeFilterRandom: TreeFilter {
    func filter(tree: Tree) -> Bool {
        return Bool.random()
    }
}
