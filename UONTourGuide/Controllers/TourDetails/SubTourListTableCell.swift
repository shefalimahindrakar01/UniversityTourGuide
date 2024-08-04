//
//  SubTourListTableCell.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 14/07/24.
//

import UIKit

class SubTourListTableCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgStop: UIView!
    @IBOutlet weak var lblStopName: UILabel!
    @IBOutlet weak var lblStopDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeMainView()
    }
    
    private func customizeMainView() {
        mainView.backgroundColor = UIColor.textColor
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
    }
    
}

