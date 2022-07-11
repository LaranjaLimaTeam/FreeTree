//
//  Tree.swift
//  FreeTree
//
//  Created by Pedro Mota on 21/06/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Tree: Codable, Equatable, Identifiable {
    static func == (lhs: Tree, rhs: Tree) -> Bool {
        return lhs.id == rhs.id
    }
    @DocumentID var id: String? = UUID().uuidString
    var creationTimeStamp: String = Date().toString()
    var name: String = "Limoeiro"
    var address: Address = Address()
    var coordinates: Coordinate = Coordinate()
    var tags: [String] = ["Limoeiro", "Azedo", "Melancia"]
    var profile: UserProfile = UserProfile()
}

struct Address: Codable {
    var street: String = ""
    var number: Int = 0
    var neighborHood: String = ""
    var city: String = ""
    var stateOrProvince: String = ""
    var zipCode: String = ""
}
