//
//  TriviaVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/08/24.
//

import UIKit
import SideMenu

struct Trivia {
    let fact: String
}

class TriviaVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menu: SideMenuNavigationController?
    
    let triviaFacts: [Trivia] = [
        Trivia(fact: "The Jubilee Campus was officially opened in 1999 by Queen Elizabeth II to mark the University's 50th anniversary as a Royal Charter University."),
        Trivia(fact: "Campus was built on a former industrial site that once housed the Raleigh Bicycle Company factory."),
        Trivia(fact: "The campus is known for its environmentally friendly design and has won multiple sustainability awards."),
        Trivia(fact: "The iconic Sir Colin Campbell Building features a distinctive cone shape and is named after a former Chancellor of the university."),
        Trivia(fact: "The campus includes several lakes that serve both aesthetic and practical purposes, helping with rainwater management and cooling."),
        Trivia(fact: "The Aspire sculpture on the campus is one of the tallest free-standing works of public art in the UK, standing at 60 metres tall."),
        Trivia(fact: "Many buildings on the campus use innovative technologies for heating and cooling, such as earth ducts and natural ventilation."),
        Trivia(fact: "The Dearing Building is named after Lord Dearing, a former Chancellor of the university who was instrumental in the campus's development."),
        Trivia(fact: "The campus features a central piazza called 'The Exchange,' which serves as a social hub for students and staff."),
        Trivia(fact: "The Jubilee Campus is connected to the main University Park campus by a frequent bus service called the Hopper Bus."),
        Trivia(fact: " The campus houses the National College for Teaching and Leadership, a government agency responsible for teacher training."),
        Trivia(fact: "The Ingenuity Centre on the campus is an innovation hub that supports technology entrepreneurs and start-ups."),
        Trivia(fact: "The campus's design was led by Sir Michael Hopkins, a renowned British architect known for sustainable building designs."),
        Trivia(fact: "The Si Yuan Centre on the campus is dedicated to the study of contemporary Chinese culture and business."),
        Trivia(fact: "The Nottingham Geospatial Institute, located on the Jubilee Campus, is a world-leading centre for satellite navigation and positioning systems research."),
        Trivia(fact: "The campus is home to the Institute for Enterprise and Innovation, which promotes entrepreneurship among students and staff."),
        Trivia(fact: "The campus's proximity to the Nottingham Science Park creates opportunities for collaboration between academia and industry."),
        Trivia(fact: " The Energy Technologies Building on campus is a state-of-the-art research facility for sustainable energy technologies."),
        Trivia(fact: "Jubilee Campus is located near the historic Wollaton Hall, a 16th-century Elizabethan country house that now serves as a natural history museum."),
    ]
    
    let colors: [UIColor] = [.primaryColor, .secondaryColor, .tertiaryColor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trivia"
        setupSideMenu()
        setupNavigationBar()
        tableView.register(UINib(nibName: "TriviaTableCell", bundle: nil), forCellReuseIdentifier: "TriviaTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
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

extension TriviaVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return triviaFacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TriviaTableCell", for: indexPath) as? TriviaTableCell else {
            return UITableViewCell()
        }
        
        let trivia = triviaFacts[indexPath.row]
        cell.lblTrivia.text = trivia.fact
        
        cell.mainView.backgroundColor = colors[indexPath.row % colors.count]
        
        return cell
    }
}

