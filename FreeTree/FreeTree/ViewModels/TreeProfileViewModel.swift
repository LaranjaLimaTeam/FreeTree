import Foundation
import Combine
import CoreLocation

class TreeProfileViewModel: ObservableObject {
    @Published var tree: Tree
    @Published var distance: Double = 0
    @Published var comments:[Comment] = []
    private let locationManager = LocationManager.shared
    var cancellable: Cancellable?

    init(tree: Tree) {
        self.tree = tree
        cancellable =  self.locationManager.$locationCoordinate
            .map { coordinate in
                let distance = self.getDistance(coordinate: tree.coordinates)
                return distance
            }.sink(receiveValue: { distance in
                self.distance = distance
            })
    }

    func getStringDate(inputDate: String) -> String {
        var newDate = inputDate
        let start = newDate.index(newDate.startIndex, offsetBy: 0)
        let end = newDate.index(newDate.startIndex, offsetBy: 10)
        let range = start..<end
        let newDateSubstring = newDate[range]
        newDate = String(newDateSubstring)
        return newDate
    }

    func getDistance(coordinate: Coordinate) -> Double {
        guard let distanceInMeters = locationManager.getDistance(coordinates: coordinate) else {return 0}
        let distanceInKm: Double = distanceInMeters*1.0/1000
        return distanceInKm
    }
    
    func insertComment(comment: Comment) {
        print("Comentário inserido")
    }
}
