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
    @Published var locationManager = LocationManager.shared

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
        guard let distanceInMeters = locationManager.getDistance(coordinates: tree.coordinates) else {return 0}
        let distanceInKm: Double = distanceInMeters*1.0/1000
        return distanceInKm
    }
}
