//
//  MapItem.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 31/7/21.
//

import Foundation
import MapKit

/// MapItem consisting coordinates
/// Can be expanded to have any other items - like custom annotation image, if needed
/// Can be expanded to have variants of images, if cluster supports come in different images required, based on some condition

final class MapItem: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    
    var pinImage: UIImage? {
        return UIImage(named: "pin")
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
