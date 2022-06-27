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
    private var completion: (() -> Void)?
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    func requestLocation(completion: @escaping () -> Void ) {
        print("DEBUG: Request location")
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
        if let completion = self.completion {
            completion()
            self.completion = nil
        }
    }
}
