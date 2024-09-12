//
//  TourDetailsVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 14/07/24.
//

import UIKit
import CoreLocation

class TourDetailsVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var currentViewController: UIViewController?
    
    lazy var firstViewController: MapVC = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapVC
    }()
    
    lazy var secondViewController: MapPreviewVC = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapPreviewVC") as! MapPreviewVC
    }()
    
    lazy var thirdViewController: SubTourListVC = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubTourListVC") as! SubTourListVC
    }()
    
    var mediaPlayerView: CustomMediaPlayerView!
    var locationManager: CLLocationManager!
    
    // Boolean flag to track if the alert has been shown
    private var alertShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tour Details"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColor]
        self.navigationController?.navigationBar.tintColor = UIColor.textColor
        configureSegmentedControlAppearance()
        
        // Display the first view controller by default
        displayViewController(firstViewController)
        
        // Setup the custom media player view
        setupMediaPlayerView()
        
        // Setup location manager
        setupLocationManager()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mediaPlayerView.hideView()
    }
    
    func configureSegmentedControlAppearance() {
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.selectedSegmentTintColor = UIColor.textColor
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.textColor,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.layer.borderWidth = 0
        segmentedControl.layer.borderColor = UIColor.clear.cgColor
        segmentedControl.layer.cornerRadius = 5
        segmentedControl.layer.masksToBounds = true
    }
    
    func displayViewController(_ viewController: UIViewController) {
        addChild(viewController)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        currentViewController = viewController
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        currentViewController?.removeFromParent()
        currentViewController?.view.removeFromSuperview()
        switch sender.selectedSegmentIndex {
        case 0:
            firstViewController.tourDetailsVC = self
            displayViewController(firstViewController)
        case 1:
            secondViewController.tourDetailsVC = self
            displayViewController(secondViewController)
        case 2:
            thirdViewController.tourDetailsVC = self
            displayViewController(thirdViewController)
        default:
            break
        }
    }
    
    func setupMediaPlayerView() {
        let mediaPlayerView = Bundle.main.loadNibNamed("CustomMediaPlayerView", owner: self, options: nil)?.first as! CustomMediaPlayerView
        self.mediaPlayerView = mediaPlayerView
        mediaPlayerView.presentInView(self.view)
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }
        
        let firstStop = GlobalData.uonLocations.first!
        let firstStopLocation = CLLocation(latitude: firstStop.latitude, longitude: firstStop.longitude)
        
        if currentLocation.distance(from: firstStopLocation) > 50 { // Assuming 50 meters as the threshold
            // Ensure alert is only shown once
            if !alertShown {
                showAlertToNavigateToFirstStop()
                alertShown = true
            }
        }
    }
    
    func showAlertToNavigateToFirstStop() {
        let alert = UIAlertController(title: "Not at First Stop", message: "You are not at the first stop. Would you like to navigate there?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Navigate", style: .default, handler: { _ in
            self.navigateToFirstStop()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToFirstStop() {
        guard let firstStop = GlobalData.uonLocations.first else { return }
        let googleMapsURL = URL(string: "comgooglemaps://?daddr=\(firstStop.latitude),\(firstStop.longitude)&directionsmode=driving")!
        let webURL = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(firstStop.latitude),\(firstStop.longitude)&travelmode=driving")!
        
        if UIApplication.shared.canOpenURL(googleMapsURL) {
            UIApplication.shared.open(googleMapsURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
}
