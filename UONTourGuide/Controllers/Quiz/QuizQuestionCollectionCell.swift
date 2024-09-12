//
//  QuizQuestionCollectionCellCollectionViewCell.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/08/24.
//

import UIKit

protocol QuizQuestionCollectionCellDelegate: AnyObject {
    func didSelectOption(optionIndex: Int, forCellAt index: Int)
}

class QuizQuestionCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    @IBOutlet weak var btnOption4: UIButton!
    
    weak var delegate: QuizQuestionCollectionCellDelegate?
    var cellIndex: Int = 0 // Index of the current cell in the collection view
    var answerSelected = false // Flag to track if answer is already selected
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Assign tags to buttons
        btnOption1.tag = 0
        btnOption2.tag = 1
        btnOption3.tag = 2
        btnOption4.tag = 3
        
        btnOption1.layer.cornerRadius = 10
        btnOption1.layer.masksToBounds = true
        btnOption1.setTitleColor(.textColor, for: .normal)
        btnOption1.layer.borderWidth = 1.0
        btnOption1.layer.borderColor = UIColor.textColor.cgColor
        
        btnOption2.layer.cornerRadius = 10
        btnOption2.layer.masksToBounds = true
        btnOption2.setTitleColor(.textColor, for: .normal)
        btnOption2.layer.borderWidth = 1.0
        btnOption2.layer.borderColor = UIColor.textColor.cgColor
        
        btnOption3.layer.cornerRadius = 10
        btnOption3.layer.masksToBounds = true
        btnOption3.setTitleColor(.textColor, for: .normal)
        btnOption3.layer.borderWidth = 1.0
        btnOption3.layer.borderColor = UIColor.textColor.cgColor
        
        btnOption4.layer.cornerRadius = 10
        btnOption4.layer.masksToBounds = true
        btnOption4.setTitleColor(.textColor, for: .normal)
        btnOption4.layer.borderWidth = 1.0
        btnOption4.layer.borderColor = UIColor.textColor.cgColor
        
        // Add common action for all buttons
        btnOption1.addTarget(self, action: #selector(btnOptionTapped(_:)), for: .touchUpInside)
        btnOption2.addTarget(self, action: #selector(btnOptionTapped(_:)), for: .touchUpInside)
        btnOption3.addTarget(self, action: #selector(btnOptionTapped(_:)), for: .touchUpInside)
        btnOption4.addTarget(self, action: #selector(btnOptionTapped(_:)), for: .touchUpInside)
    }
    
    func configure(with questionData: (question: String, options: [String], correctAnswerIndex: Int, imageName: String, userSelectedAnswerIndex: Int?)) {
        imgQuestion.image = UIImage(named: questionData.imageName)
        lblQuestion.text = questionData.question
        btnOption1.setTitle(questionData.options[0], for: .normal)
        btnOption2.setTitle(questionData.options[1], for: .normal)
        btnOption3.setTitle(questionData.options[2], for: .normal)
        btnOption4.setTitle(questionData.options[3], for: .normal)
        
        // Reset button backgrounds if nothing selected
        let buttons = [btnOption1, btnOption2, btnOption3, btnOption4]
        buttons.forEach { $0?.backgroundColor = UIColor.clear }
        
        // Highlight selected answer if any
        if let selectedIndex = questionData.userSelectedAnswerIndex {
            if selectedIndex == questionData.correctAnswerIndex {
                // Correct answer selected
                buttons[selectedIndex]?.backgroundColor = UIColor.green
            } else {
                // Incorrect answer selected
                buttons[selectedIndex]?.backgroundColor = UIColor.red
                buttons[questionData.correctAnswerIndex]?.backgroundColor = UIColor.green
            }
            
            // Disable all option buttons after an answer is selected
            buttons.forEach { $0?.isEnabled = false }
            answerSelected = true
        } else {
            // Enable buttons if no answer is selected
            buttons.forEach { $0?.isEnabled = true }
            answerSelected = false
        }
    }
    
    @objc func btnOptionTapped(_ sender: UIButton) {
        guard let delegate = delegate, !answerSelected else { return }
        let optionIndex = sender.tag
        delegate.didSelectOption(optionIndex: optionIndex, forCellAt: cellIndex)
        
        // Disable all option buttons after an answer is selected
        let buttons = [btnOption1, btnOption2, btnOption3, btnOption4]
        buttons.forEach { $0?.isEnabled = false }
        answerSelected = true
    }
}
