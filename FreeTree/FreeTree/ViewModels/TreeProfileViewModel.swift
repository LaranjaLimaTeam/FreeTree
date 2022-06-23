//
//  TreeProfileViewModel.swift
//  FreeTree
//
//  Created by Nathan Batista de Oliveira on 23/06/22.
//

import Foundation
import CoreLocation

class TreeProfileViewModel: ObservableObject {
    @Published var tree: Tree
    let currentLocation: Coordinate = Coordinate()

    init(tree: Tree) {
        self.tree = tree
    }

    func getStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        let date = tree.creationDate
        var newDate = date.formatted()
        let start = newDate.index(newDate.startIndex, offsetBy: 0)
        let end = newDate.index(newDate.startIndex, offsetBy: 10)
        let range = start..<end
        let newDateSubstring = newDate[range]
        newDate = String(newDateSubstring)
        return newDate
    }

    func getDistance() -> Double {
        let coordinate1 = CLLocation(latitude: tree.coordinates.latitude, longitude: tree.coordinates.longitude)
        let coordinate2 = CLLocation(latitude: 0.5, longitude: 0.0)

        let distanceInMeters = coordinate1.distance(from: coordinate2)
        let distanceInKm: Double = distanceInMeters*1.0/1000
        return distanceInKm
    }
}
