//
//  File.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/08/24.
//

import UIKit
import SideMenu

class AboutAppVC: UIViewController {
    
    @IBOutlet weak var aboutTextView: UITextView!
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About"
        setupSideMenu()
        setupNavigationBar()
        self.aboutTextView.attributedText = GlobalData.aboutYou.htmlToAttributedString
        self.aboutTextView.isEditable = false
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

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
