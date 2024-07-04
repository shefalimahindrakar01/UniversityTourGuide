//
//  TourListTableCell.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/07/24.
//

import UIKit

protocol TourListTableCellDelegate: AnyObject {
    func didTapStartTour(tourName: String)
}

class TourListTableCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTourName: UILabel!
    @IBOutlet weak var lblTourDescription: UILabel!
    @IBOutlet weak var btnStartTour: UIButton!
    
    weak var delegate: TourListTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = UIColor.textColor
        btnStartTour.layer.cornerRadius = btnStartTour.frame.height / 2
        btnStartTour.backgroundColor = UIColor.white
        btnStartTour.setTitleColor(UIColor.textColor, for: .normal)
    }
    
    private func setupUI() {
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = UIColor.textColor
        btnStartTour.layer.cornerRadius = btnStartTour.frame.height / 2
        btnStartTour.backgroundColor = UIColor.white
        btnStartTour.setTitleColor(UIColor.textColor, for: .normal)
    }
    
    func configure(with tour: Tour) {
        lblTourName.text = tour.name
        lblTourDescription.text = tour.description
    }
    
    @IBAction func btnStartTourTapped(_ sender: UIButton) {
        delegate?.didTapStartTour(tourName: lblTourName.text ?? "")
    }
    
}
