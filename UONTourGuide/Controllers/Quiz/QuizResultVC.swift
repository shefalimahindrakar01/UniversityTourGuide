//
//  QuizResultVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/08/24.
//

import UIKit

class QuizResultVC: UIViewController {
    
    @IBOutlet weak var lblTotalScore: UILabel!
    @IBOutlet weak var lblScoreStatus: UILabel!
    @IBOutlet weak var btnRestartQuiz: UIButton!
    
    var totalQuestions = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayScore()
        lblTotalScore.textColor = .textColor
        btnRestartQuiz.applyGradient(colors: [.primaryColor, .secondaryColor, .tertiaryColor])
        btnRestartQuiz.layer.cornerRadius = 10
        btnRestartQuiz.layer.masksToBounds = true
        navigationItem.hidesBackButton = true
    }
    
    func displayScore() {
        lblTotalScore.text = "\(score) / \(totalQuestions)"
        
        // Determine score status
        if totalQuestions > 0 {
            let percentage = Double(score) / Double(totalQuestions) * 100
            if percentage >= 75 {
                lblScoreStatus.text = "Excellent!"
            } else if percentage >= 50 {
                lblScoreStatus.text = "Good!"
            } else if percentage >= 25 {
                lblScoreStatus.text = "Average!"
            } else {
                lblScoreStatus.text = "Poor!"
            }
        } else {
            lblScoreStatus.text = "No questions attempted."
        }
    }
    
    @IBAction func btnRestartQuizTapped(_ sender: UIButton) {
        // Reset quiz state
        for controller in navigationController?.viewControllers ?? [] {
            if let quizQuestionVC = controller as? QuizQuestionVC {
                quizQuestionVC.currentQuestionIndex = 0
                quizQuestionVC.score = 0
                quizQuestionVC.quizData = GlobalData.quizData
                DispatchQueue.main.async {
                    quizQuestionVC.collectionView.reloadData()
                    quizQuestionVC.updateUI()
                    quizQuestionVC.updateNavigationButtons()
                }
                navigationController?.popToViewController(quizQuestionVC, animated: true)
                break
            }
        }
    }
    
}

