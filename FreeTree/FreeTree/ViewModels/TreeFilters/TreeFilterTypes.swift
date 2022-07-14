//
//  TreeFilterType.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 13/07/22.
//

import Foundation

enum TreeFilterTypes {
    case onlyFruitful
    case byUser(user: UserProfile)
    case all
    case byTree(tree: Tree)
    case random
    case none
}
