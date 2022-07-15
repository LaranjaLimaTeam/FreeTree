//
//  TreeFilterFruitful.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 13/07/22.
//

import Foundation

class TreeFilterFruitful: TreeFilter {
    func filter(tree: Tree) -> Bool {
        tree.tags.contains { $0 == "frutífera" }
    }
}
