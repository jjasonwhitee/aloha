//
//  GeoLocation.swift
//  aloha
//
//  Created by Jason White on 20/05/24.
//

import Foundation
import MapKit

struct GeoLocation {
    let name: String
    let streetName: String
    let city: String
    let state: String
    let country: String
    init(with placemark: CLPlacemark) {
            self.name           = placemark.name ?? ""
            self.streetName     = placemark.thoroughfare ?? ""
            self.city           = placemark.locality ?? ""
            self.state          = placemark.administrativeArea ?? ""
            self.country        = placemark.country ?? ""
        }

}
