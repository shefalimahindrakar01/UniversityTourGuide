//
//  SubTourListVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 14/07/24.
//

import UIKit
import CoreLocation

class SubTourListVC: UIViewController {
    
    @IBOutlet weak var storyListTableView: UITableView!
    
    var tourDetailsVC: TourDetailsVC!
    let cellReuseIdentifier = "SubTourListTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the nib for the custom cell
        let nib = UINib(nibName: "SubTourListTableCell", bundle: nil)
        storyListTableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        
        storyListTableView.dataSource = self
        storyListTableView.delegate = self
        storyListTableView.reloadData()
    }
    
}

extension SubTourListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalData.uonLocations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Set the height of the cells to 60 points
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SubTourListTableCell
        let location = GlobalData.uonLocations[indexPath.row]
        cell.lblStopName.text = location.name
        cell.lblStopDescription.text = location.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
}

