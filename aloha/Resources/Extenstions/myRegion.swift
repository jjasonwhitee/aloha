//
//  myRegion.swift
//  aloha
//
//  Created by Jason White on 19/05/24.
//

import Foundation
import MapKit

extension MKCoordinateRegion{
    static var myRegion: MKCoordinateRegion{
        return .init(center: .myLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}
