//
//  TourDetailsVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 14/07/24.
//

import UIKit

class TourDetailsVC: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tour Details"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColor]
        self.navigationController?.navigationBar.tintColor = UIColor.textColor
        configureSegmentedControlAppearance()
        
        // Display the first view controller by default
        displayViewController(firstViewController)
        
    
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
    
   
}


