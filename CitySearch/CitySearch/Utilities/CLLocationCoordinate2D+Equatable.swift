//
//  CLLocationCoordinate2D+Equatable.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 31/7/21.
//

import Foundation
import CoreLocation.CLLocation

extension CLLocationCoordinate2D {
   public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.latitude
    }
}
