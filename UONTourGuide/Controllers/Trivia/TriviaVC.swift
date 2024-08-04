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
        Trivia(fact: "Bananas are berries, but strawberries are not."),
        Trivia(fact: "Honey never spoils. Archaeologists have found pots of honey in ancient Egyptian tombs that are over 3,000 years old and still edible."),
        Trivia(fact: "The Eiffel Tower can be 15 cm taller during the summer, due to thermal expansion of the iron."),
        Trivia(fact: "A day on Venus is longer than a year on Venus."),
        Trivia(fact: "There are more stars in the universe than grains of sand on all the world's beaches."),
        Trivia(fact: "Octopuses have three hearts."),
        Trivia(fact: "The shortest war in history lasted 38 to 45 minutes."),
        Trivia(fact: "Hot water freezes faster than cold water. This is known as the Mpemba effect."),
        Trivia(fact: "The longest place name on the planet is 85 letters long."),
        Trivia(fact: "There are more possible iterations of a game of chess than there are atoms in the known universe."),
        Trivia(fact: "Wombat poop is cube-shaped."),
        Trivia(fact: "Humans share 60% of their DNA with bananas.")
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

