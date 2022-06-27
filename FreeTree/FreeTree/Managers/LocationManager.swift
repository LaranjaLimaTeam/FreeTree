//
//  LocationManager.swift
//  learn-maps-swiftui
//
//  Created by Giordano Mattiello on 21/06/22.
//
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published private(set) var locationCoordinate: Coordinate?
    static let shared = LocationManager()
    let defaultLocation = CLLocationCoordinate2D(latitude: 37.334803, longitude: -122.008965)

    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    func requestLocation() {
        print("DEBUG: Request location")
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
            print("DEBUG: Not Determined")
        case .restricted:
            print("DEBUG: Restricted")
        case .denied:
            print("DEBUG: Denied")
        case .authorizedAlways:
            print("DEBUG: Authorized Always")
        case .authorizedWhenInUse:
            print("DEBUG: Authorized When In Use")
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
    }
}

extension LocationManager {
    func createCLLocation(coordinate:Coordinate) -> CLLocation {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return location
    }
}
