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
}

extension Coordinate {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
