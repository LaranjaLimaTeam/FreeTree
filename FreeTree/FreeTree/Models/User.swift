//
//  User.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 23/06/22.
//

import Foundation
import FirebaseFirestoreSwift

struct UserProfile: Codable, Identifiable {
    @DocumentID var id = UUID().uuidString
    var name: String = "Karina Costa"
    var email: String = ""
    var imageName: String = "person"
}
