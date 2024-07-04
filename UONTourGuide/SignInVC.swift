//
//  SignInVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/07/24.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    
    private var passwordVisibilityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.applyGradient(colors: [UIColor.primaryColor, UIColor.secondaryColor, UIColor.tertiaryColor])
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let borderColor = UIColor.white
        let borderWidth: CGFloat = 1.0
        let cornerRadius: CGFloat = 10.0
        btnSignIn.customizeBorderAndCornerRadius(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius)
        
        setupPasswordVisibilityButton()
    }
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let userName = userNameTF.text, !userName.isEmpty else {
            showErrorSnackbar(message: "Please enter your email.")
            return
        }
        
        guard isValidEmail(userName) else {
            showErrorSnackbar(message: "Please enter a valid email address.")
            return
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            showErrorSnackbar(message: "Please enter your password.")
            return
        }
        
        signInUser(withEmail: userName, password: password)
    }
    
    func signInUser(withEmail email: String, password: String) {
        showLoadingIndicator()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            hideLoadingIndicator()
            
            if let error = error {
                showErrorSnackbar(message: error.localizedDescription)
                return
            }
            
            showSuccessSnackbar(message: "Sign in successful!")
            
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                    let navigationController = UINavigationController(rootViewController: homeVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    UIApplication.shared.windows.first?.rootViewController = navigationController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
        }
    }
    
    private func setupPasswordVisibilityButton() {
        passwordTF.isSecureTextEntry = true
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let eyeImage = UIImage(systemName: "eye", withConfiguration: configuration)
        
        let button = UIButton(type: .system)
        button.setImage(eyeImage, for: .normal)
        button.tintColor = .lightGray
        button.addAction(UIAction(handler: { _ in
            self.passwordTF.isSecureTextEntry.toggle()
            let newImage = UIImage(systemName: self.passwordTF.isSecureTextEntry ? "eye" : "eye.slash", withConfiguration: configuration)
            button.setImage(newImage, for: .normal)
        }), for: .touchUpInside)
        
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        
        passwordTF.rightView = button
        passwordTF.rightViewMode = .always
        passwordVisibilityButton = button
    }
    
}

