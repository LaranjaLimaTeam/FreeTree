//
//  Tree.swift
//  FreeTree
//
//  Created by Pedro Mota on 21/06/22.
//

import Foundation

struct Tree: Codable, Equatable {
    static func == (lhs: Tree, rhs: Tree) -> Bool {
        return lhs.id == rhs.id
    }
    var id = UUID()
    var creationTimeStamp: String = "27/06/2022 12:00"
    var name: String = "Limoeiro"
    var address: Address = Address()
    var coordinates: Coordinate = Coordinate()
    var tags: [String] = ["Limoeiro", "Azedo", "Melancia"]
    var profile: UserProfile = UserProfile()
    var images: [Data] = []
}

struct Address: Codable {
    var street: String = ""
    var number: Int = 0
    var neighborHood: String = ""
    var city: String = ""
    var stateOrProvince: String = ""
    var zipCode: String = ""
}
