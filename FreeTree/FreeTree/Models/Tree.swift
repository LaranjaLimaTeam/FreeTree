//
//  Tree.swift
//  FreeTree
//
//  Created by Pedro Mota on 21/06/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Tree: Codable, Equatable, Identifiable {
    
    @DocumentID var id: String? = UUID().uuidString
    
    var name: String = ""
    var creationTimeStamp: String = Date().toString()
    var coordinates: Coordinate = Coordinate()
    var address: Address = Address()
    var tags: [String] = ["Limoeiro", "Azedo", "Melancia"]
    var profile: UserProfile = UserProfile()
    var wasPlantedByUser: Bool = false
    var isFruitful: Bool = false
    
    static func == (lhs: Tree, rhs: Tree) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Address: Codable {
    var street: String = ""
    var number: Int = 0
    var neighborHood: String = ""
    var city: String = ""
    var stateOrProvince: String = ""
    var zipCode: String = ""
}
