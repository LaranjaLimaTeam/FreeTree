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

struct Coordinate: Codable {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}
