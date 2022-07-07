//
//  Comment.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 27/06/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Comment: Identifiable, Equatable, Codable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }
    
    var treeId: String
    @DocumentID var id: String? = UUID().uuidString
    var user: UserProfile = UserProfile()
    var comment: String = ""
    var date = Date().toString()
}

struct Photo: Identifiable, Codable {
    var treeId: String
    @DocumentID var id: String? = UUID().uuidString
}
