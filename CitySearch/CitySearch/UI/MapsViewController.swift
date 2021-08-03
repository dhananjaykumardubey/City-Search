//
//  MapsViewController.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 31/7/21.
//

import Foundation
import UIKit
import MapKit

final class MapsViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView! {
        didSet {
            self.mapView.delegate = self
        }
    }
    
    @IBOutlet private weak var openMapButton: UIButton! {
        didSet {
            self.openMapButton.setImage(UIImage(named: "locationMark")?.resizeImage(CGSize(width: 25.0, height: 25.0)).tinted(with: .white), for: .normal)
            self.openMapButton.addTarget(self, action: #selector(self.openInMaps), for: .touchUpInside)
            self.openMapButton.layer.cornerRadius = CGFloat(25.0)
            self.openMapButton.backgroundColor = .orange
        }
    }
    
    private lazy var coordinates = CLLocationCoordinate2D()
    private var locationName = ""
    
    static func instantiate(with coordinates: CLLocationCoordinate2D, locationName: String) -> MapsViewController {
        let vc = Storyboard.Main.instantiate(MapsViewController.self)
        vc.coordinates = coordinates
        vc.locationName = locationName
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        OperationQueue.main.addOperation { [weak self] in
            guard let _self = self else { return }
            _self.mapView.addAnnotation(_self.mappedAnnotations())
            _self.mapView.setCenterAndZoom(_self.coordinates, zoomBy: 14.0, animated: true)
        }
        self.openMapButton.bounceOut(delay: 1.0)
    }
    
    private func mappedAnnotations() -> MapItem {
        return MapItem(coordinate: self.coordinates)
    }
    
    @objc private func openInMaps() {
        guard let annotation = self.mapView.annotations.first else { return }
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: annotation.coordinate)
        ] as [String: Any]
        let placemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.locationName
        mapItem.openInMaps(launchOptions: options)
    }
}

extension MapsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MapItem else { return nil }
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: "reuseId")
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: "reuseId")
        } else {
            anView?.annotation = annotation
        }
        anView?.image = annotation.pinImage
        return anView
    }
}
