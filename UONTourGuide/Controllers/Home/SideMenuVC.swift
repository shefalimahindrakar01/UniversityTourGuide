//
//  SideMenuVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/07/24.
//

import UIKit
import FirebaseAuth

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAppVersion: UILabel!
    
    let menuItems = ["Home", "About", "University Info", "Quiz", "Trivia", "Feedback", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.applyGradient(colors: [UIColor.primaryColor, UIColor.secondaryColor, UIColor.tertiaryColor])
        fetchAndDisplayUserName()
        displayAppVersion()
        setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "SideMenuTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SideMenuTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func fetchAndDisplayUserName() {
        guard let user = Auth.auth().currentUser else {
            print("No user is signed in.")
            return
        }
        let displayName = user.email ?? "No Name Available"
        lblUserName.text = displayName
    }
    
    func displayAppVersion() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            lblAppVersion.text = "App Version \(version) (\(build))"
        } else {
            lblAppVersion.text = "Version info not available"
        }
    }
    
    func signOut() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.performSignOut()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func performSignOut() {
        showLoadingIndicator()
        do {
            UserDefaults.standard.removeObject(forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
            try Auth.auth().signOut()
            hideLoadingIndicator()
            showSuccessSnackbar(message: "Sign out successful!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") {
                    UIApplication.shared.windows.first?.rootViewController = viewController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
        } catch let signOutError as NSError {
            hideLoadingIndicator()
            showErrorSnackbar(message: signOutError.localizedDescription)
        }
    }
    
    @IBAction func btnInstagramTapped(_ sender: UIButton) {
        openURL("https://www.instagram.com/dummyPage")
    }
    
    @IBAction func btnFacebookTapped(_ sender: UIButton) {
        openURL("https://www.facebook.com/dummyPage")
    }
    
    @IBAction func btnTwitterTapped(_ sender: UIButton) {
        openURL("https://twitter.com/dummyPage")
    }
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL: \(urlString)")
        }
    }
}

// MARK: - UITableViewDataSource
extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableCell", for: indexPath) as? SideMenuTableCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.lblMenuItem.text = menuItems[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SideMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        switch selectedItem {
        case "Home":
            openViewController(withIdentifier: "HomeVC")
        case "About":
            openViewController(withIdentifier: "AboutAppVC")
        case "University Info":
            openViewController(withIdentifier: "UniversityInfoVC")
        case "Quiz":
            openViewController(withIdentifier: "QuizVC")
        case "Trivia":
            openViewController(withIdentifier: "TriviaVC")
        case "Feedback":
            presentViewController(withIdentifier: "FeedbackVC")
        case "Logout":
            signOut()
        default:
            break
        }
    }
    
    private func openViewController(withIdentifier identifier: String) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: identifier) else {
            return
        }
        
        // Check if the view controller is already in the navigation stack
        if let navigationController = navigationController {
            if let topViewController = navigationController.topViewController, topViewController.isKind(of: viewController.classForCoder) {
                // Already at this view controller, do nothing
                return
            }
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentViewController(withIdentifier identifier: String) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: identifier) else {
            return
        }
        
        // Present the view controller modally
        present(viewController, animated: true, completion: nil)
    }
    
}
