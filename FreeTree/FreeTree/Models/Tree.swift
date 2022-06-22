//
//  Tree.swift
//  FreeTree
//
//  Created by Pedro Mota on 21/06/22.
//

struct Tree: Codable {
    var name: String = ""
    var address: Address = Address()
    var coordinates: Coordinate = Coordinate()
}

struct Address: Codable {
    var street: String = ""
    var number: Int = 0
    var neighborHood: String = ""
    var city: String = ""
    var stateOrProvince: String = ""
    var zipCode: String = ""
}
