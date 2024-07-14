//
//  MapVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 14/07/24.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    var locationManager: CLLocationManager!
    var lastLocationUpdate: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Create and configure map view
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        view.addSubview(mapView)
        
        // Add blue polyline
        let polyline = GMSPolyline()
        polyline.strokeColor = .blue
        polyline.strokeWidth = 2.0
        var path = GMSMutablePath()
        
        // Add circles and connect with polyline
        for location in GlobalData.uonLocations {
            let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), radius: 10.0)
            circle.fillColor = UIColor.red.withAlphaComponent(0.5)
            circle.map = mapView
            
            path.add(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        
        polyline.path = path
        polyline.map = mapView
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if let lastLocation = lastLocationUpdate, location.distance(from: lastLocation) < 10 {
            // Only update the map if the location has significantly changed
            return
        }
        lastLocationUpdate = location
        
        // Adjust camera to fit all locations and user's location
        var bounds = GMSCoordinateBounds()
        for location in locations {
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            bounds = bounds.includingCoordinate(coordinate)
        }
        for location in GlobalData.uonLocations {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            bounds = bounds.includingCoordinate(coordinate)
        }
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100.0) // Adjust padding as needed
        mapView.animate(with: update)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
    }
}

