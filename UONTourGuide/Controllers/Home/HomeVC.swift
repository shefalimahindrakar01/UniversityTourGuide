//
//  HomeVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/07/24.
//

import UIKit
import SideMenu

struct Tour {
    var name: String
    var description: String
    var imageName: String
}

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menu: SideMenuNavigationController?
    
    var tours: [Tour] = [
        Tour(name: "University of Nottingham UK", description: "Description of University of Nottingham UK Tour", imageName: "img_tour1"),
        Tour(name: "University of Nottingham China", description: "Coming Soon", imageName: "img_tour2"),
        Tour(name: "University of Nottingham Malaysia", description: "Coming Soon", imageName: "img_tour3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        setupNavigationBar()
        setupSideMenu()
        tableView.register(UINib(nibName: "TourListTableCell", bundle: nil), forCellReuseIdentifier: "TourListTableCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupSideMenu() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let sideMenuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC else {
            fatalError("Unable to instantiate SideMenuVC from the storyboard")
        }
        menu = SideMenuNavigationController(rootViewController: sideMenuVC)
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    private func setupNavigationBar() {
        let menuButton = UIButton(type: .custom)
        let image = UIImage(systemName: "line.horizontal.3")
        menuButton.setImage(image, for: .normal)
        menuButton.tintColor = UIColor.textColor
        menuButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        let menuBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItem = menuBarButtonItem
    }
    
    @objc private func menuButtonTapped() {
        present(menu!, animated: true)
    }
    
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tours.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TourListTableCell", for: indexPath) as! TourListTableCell
        cell.selectionStyle = .none
        cell.delegate = self
        let tour = tours[indexPath.row]
        cell.configure(with: tour, index: indexPath.row)
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    
}

extension HomeVC: TourListTableCellDelegate {
    func didTapStartTour(tourName: String, index: Int) {
        switch index {
        case 0:
            guard let segmentedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TourDetailsVC") as? TourDetailsVC else {
                return
            }
            navigationController?.pushViewController(segmentedViewController, animated: true)
        case 1:
            showErrorSnackbar(message: "Coming Soon")
        case 2:
            showErrorSnackbar(message: "Coming Soon")
        default:
            showErrorSnackbar(message: "Coming Soon")
        }
    }
}
