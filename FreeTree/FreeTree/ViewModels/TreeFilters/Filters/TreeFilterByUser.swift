//
//  TreeFilterPersonal.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 13/07/22.
//

import Foundation

class TreeFilterByUser: TreeFilter{
    let user: UserProfile
    init(user: UserProfile) {
        self.user = user
    }
    func filter(tree: Tree) -> Bool {
        return tree.profile == self.user
    }
}
