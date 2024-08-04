//
//  MapPreviewVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 14/07/24.
//

import UIKit
import GoogleMaps

class MapPreviewVC: UIViewController, GMSMapViewDelegate {
    
    var markerToIndexMap: [GMSMarker: Int] = [:]
    var tourDetailsVC: TourDetailsVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 52.9442, longitude: -1.1817, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        var bounds = GMSCoordinateBounds()
        var polylineCoordinates = [CLLocationCoordinate2D]()
        
        for (index, location) in GlobalData.uonLocations.enumerated() {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            marker.title = "\(index + 1). \(location.name)"
            marker.map = mapView
            
            markerToIndexMap[marker] = index
            polylineCoordinates.append(marker.position)
            bounds = bounds.includingCoordinate(marker.position)
        }
        
        // Add blue polyline
        let polyline = GMSPolyline(path: GMSMutablePath())
        polyline.strokeColor = .blue
        polyline.strokeWidth = 2.0
        polyline.map = mapView
        let path = GMSMutablePath()
        for coordinate in polylineCoordinates {
            path.add(coordinate)
        }
        polyline.path = path
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
        mapView.animate(with: update)
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let index = markerToIndexMap[marker] {
            presentMediaPlayerVC(for: index)
        }
    }
    
    func presentMediaPlayerVC(for index: Int) {
        self.tourDetailsVC.mediaPlayerView.presentInView(self.tourDetailsVC.view)
        self.tourDetailsVC.mediaPlayerView.loadAudio(at: index)
    }
}
