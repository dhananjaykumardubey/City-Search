//
//  MKMapView+Enhancements.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 31/7/21.
//

import Foundation
import MapKit

extension MKMapView {
    
    func setCenterAndZoom(_ centerCoordinates: CLLocationCoordinate2D,
                          zoomBy zoomLevel: Double,
                          animated: Bool) {
        
        let span = MKCoordinateSpan(latitudeDelta: self.region.span.latitudeDelta / zoomLevel,
                                    longitudeDelta: self.region.span.longitudeDelta / zoomLevel)
        let coordinatedRegion = MKCoordinateRegion(center: centerCoordinates, span: span)
        self.setRegion(coordinatedRegion, animated: animated)
    }
}

