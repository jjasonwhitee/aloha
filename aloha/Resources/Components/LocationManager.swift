//import Foundation
//import MapKit
//import CoreLocation
//
//class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
//    @Published var manager: CLLocationManager = .init()
//    @Published var userLocation: CLLocationCoordinate2D = .init(latitude: -6.3025, longitude: 106.6520)
//    @Published var isLocationAuthorized: Bool = false
//    
//    override init() {
//        super.init()
//        
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//    }
//    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkAuthorization()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let currentLocation = locations.last else { return }
//        
//        print(currentLocation)
//        
//        userLocation = currentLocation.coordinate
//        isLocationAuthorized = true
//    }
//    
//    func checkAuthorization() {
//        switch manager.authorizationStatus {
//        case .notDetermined:
//            print("Location is not determined")
//            manager.requestWhenInUseAuthorization()
//            
//        case .denied:
//            print("Location is denied")
//            
//        case .authorizedAlways, .authorizedWhenInUse:
//            print("Location permission granted")
//            manager.startUpdatingLocation() // Start updating location when permission is granted
//        default:
//            break
//        }
//    }
//}

import Foundation
import CoreLocation
import Combine

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var manager: CLLocationManager = .init()
    @Published var userLocation: CLLocationCoordinate2D = .init(latitude: -6.3025, longitude: 200.6520)
    @Published var userAddress: String = ""
    @Published var userCity: String = ""
    @Published var userCountry: String = ""
    @Published var isLocationAuthorized: Bool = false

    private let geocoder = CLGeocoder()

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }

        print(currentLocation)

        userLocation = currentLocation.coordinate
        isLocationAuthorized = true
        reverseGeocode(location: currentLocation)
    }

    func checkAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Location is not determined")
            manager.requestWhenInUseAuthorization()

        case .denied:
            print("Location is denied")

        case .authorizedAlways, .authorizedWhenInUse:
            print("Location permission granted")
            manager.startUpdatingLocation() // Start updating location when permission is granted
        default:
            break
        }
    }

    func reverseGeocode(location: CLLocation) {
        let userLocation = self.userLocation
        let coordinate = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        geocoder.reverseGeocodeLocation(coordinate) { [weak self] placemarks, error in
            guard let self = self else { return }
            guard let placemark = placemarks?.first else { return }
            
            let reversedGeoLocation = GeoLocation(with: placemark)
            self.userAddress = reversedGeoLocation.name
            self.userCity = reversedGeoLocation.city
            self.userCountry = reversedGeoLocation.country
            
            print("Place Name: \(self.userAddress)")
        }
    }
    
    
    
}
