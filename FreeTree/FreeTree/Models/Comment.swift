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
    var comment =  """
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 Nunc ut diam ipsum vulputate vivamus urna, odio viverra.
Ut massa facilisis vel tempor nunc feugiat viverra sed.
 Molestie ipsum nulla pretium, erat nibh aenean neque, eget posuere.
 Morbi dignissim dignissim suspendisse vestibulum.
"""
    var date = "27/07/2022 12:00"
}

struct Photo: Identifiable, Codable {
    var treeId: String
    @DocumentID var id: String? = UUID().uuidString
}
