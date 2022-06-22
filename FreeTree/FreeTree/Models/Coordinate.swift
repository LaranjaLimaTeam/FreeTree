//
//  Coordinate.swift
//  FreeTree
//
//  Created by Giordano Mattiello on 22/06/22.
//

import MapKit

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
    init(latitude: Double = 0.0, longitude: Double = 0.0) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Coordinate {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
