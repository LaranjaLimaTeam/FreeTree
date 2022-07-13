//
//  TreeFilterType.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 13/07/22.
//

import Foundation

enum TreeFilterTypes {
    case fruitful
    case personal(user: UserProfile)
    case all
    case onRoute(tree: Tree)
    case random
}
