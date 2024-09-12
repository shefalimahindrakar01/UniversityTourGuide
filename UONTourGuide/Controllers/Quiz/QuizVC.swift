//
//  QuizVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/08/24.
//

import UIKit
import SideMenu
import TTGSnackbar

class QuizVC: UIViewController {
    
    @IBOutlet weak var lblWelcomeToQuiz: UILabel!
    @IBOutlet weak var btnStartQuiz: UIButton!
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quiz"
        lblWelcomeToQuiz.textColor = .textColor
        btnStartQuiz.applyGradient(colors: [.primaryColor, .secondaryColor, .tertiaryColor])
        btnStartQuiz.layer.cornerRadius = 10
        btnStartQuiz.layer.masksToBounds = true
        setupSideMenu()
        setupNavigationBar()
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
    
    @IBAction func btnStartQuizTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let quizQuestionVC = storyboard.instantiateViewController(withIdentifier: "QuizQuestionVC") as? QuizQuestionVC {
            self.navigationController?.pushViewController(quizQuestionVC, animated: true)
        }
    }
}

