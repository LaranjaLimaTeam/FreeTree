//
//  LocationManager.swift
//  learn-maps-swiftui
//
//  Created by Giordano Mattiello on 21/06/22.
//
import CoreLocation
import os.log

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published private(set) var locationCoordinate: Coordinate?
    static let shared = LocationManager()
    let defaultLocation = CLLocationCoordinate2D(latitude: 37.334803, longitude: -122.008965)
    private var completion: (() -> Void)?
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    func requestLocation(completion: @escaping () -> Void ) {
        os_log("Request location", log: .default, type: .debug)
        self.completion = completion
        manager.requestWhenInUseAuthorization()
    }
    func checkIfLocationServiceIsEnable() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    func isLocationAuthorized() -> Bool {
        return manager.authorizationStatus == CLAuthorizationStatus.authorizedAlways ||
        manager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse
    }
    
    func getDistance(coordinates: Coordinate) -> Double? {
        if let safeLocation = locationCoordinate {
            let coordinate1 = createCLLocation(coordinate: coordinates)
            let coordinate2 = createCLLocation(coordinate: safeLocation)

            let distanceInMeters = coordinate1.distance(from: coordinate2)
            return distanceInMeters
        }
        return nil
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            os_log("Location Manager Authorization %@", log: .default, type: .debug, "Not Determined")
        case .restricted:
            os_log("Location Manager Authorization %@", log: .default, type: .debug, "Restricted")
        case .denied:
            os_log("Location Manager Authorization %@", log: .default, type: .debug, "Denied")
        case .authorizedAlways:
            os_log("Location Manager Authorization %@", log: .default, type: .debug, "Authorized Always")
        case .authorizedWhenInUse:
            os_log("Location Manager Authorization %@", log: .default, type: .debug, "Authorized When In Use")
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let coordenate = Coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.locationCoordinate = coordenate
        if let completion = self.completion {
            completion()
            self.completion = nil
        }
    }
}

extension LocationManager {
    func createCLLocation(coordinate: Coordinate) -> CLLocation {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return location
    }
}
