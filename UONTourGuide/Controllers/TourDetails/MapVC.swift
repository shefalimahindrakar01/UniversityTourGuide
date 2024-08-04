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
    var regions: [GMSCircle] = []
    var tourDetailsVC: TourDetailsVC!
    
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
        
        // Add blue polyline and circles
        let polyline = GMSPolyline()
        polyline.strokeColor = .blue
        polyline.strokeWidth = 2.0
        var path = GMSMutablePath()
        
        for location in GlobalData.uonLocations {
            let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), radius: 10.0)
            circle.fillColor = UIColor.red.withAlphaComponent(0.5)
            circle.strokeColor = .black
            circle.strokeWidth = 1.0
            circle.map = mapView
            regions.append(circle)
            
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
        
        // Check if the user is inside any region
        for region in regions {
            if isLocation(location.coordinate, within: region) {
                handleRegionEntry(region: region)
                break
            }
        }
        
        // Adjust camera to fit all locations and user's location
        var bounds = GMSCoordinateBounds()
        for location in locations {
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            bounds = bounds.includingCoordinate(coordinate)
        }
        for region in regions {
            let coordinate = region.position
            bounds = bounds.includingCoordinate(coordinate)
        }
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100.0) // Adjust padding as needed
        mapView.animate(with: update)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
    }
    
    // MARK: - Handle region entry
    func handleRegionEntry(region: GMSCircle) {
        // Find the index of the region
        if let regionIndex = regions.firstIndex(where: { $0 === region }), regionIndex < GlobalData.uonLocations.count {
            let mediaIndex = GlobalData.uonLocations[regionIndex].mediaIndex
            presentMediaPlayerVC(for: mediaIndex)
        } else {
            print("Region index not found.")
        }
    }
    
    func presentMediaPlayerVC(for index: Int) {
        self.tourDetailsVC.mediaPlayerView.presentInView(self.tourDetailsVC.view)
        self.tourDetailsVC.mediaPlayerView.loadAudio(at: index)
    }
    
    // MARK: - Helper Methods
    func isLocation(_ coordinate: CLLocationCoordinate2D, within circle: GMSCircle) -> Bool {
        let circleCenter = CLLocation(latitude: circle.position.latitude, longitude: circle.position.longitude)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let distance = circleCenter.distance(from: location)
        return distance <= circle.radius
    }
}
