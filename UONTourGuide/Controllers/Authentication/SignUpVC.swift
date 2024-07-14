//
//  SignUpVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 23/06/24.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    private var passwordVisibilityButton: UIButton!
    private var confirmPasswordVisibilityButton: UIButton!
    
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
        btnSignUp.customizeBorderAndCornerRadius(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius)
        
        setupPasswordVisibilityButton()
        setupConfirmPasswordVisibilityButton()
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
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
        
        guard let confirmPassword = confirmPasswordTF.text, !confirmPassword.isEmpty else {
            showErrorSnackbar(message: "Please confirm your password.")
            return
        }
        
        guard password == confirmPassword else {
            showErrorSnackbar(message: "Passwords do not match.")
            return
        }
        
        signUpUser(withEmail: userName, password: password)
    }
    
    func signUpUser(withEmail email: String, password: String) {
        showLoadingIndicator()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            hideLoadingIndicator()
            if let error = error {
                showErrorSnackbar(message: error.localizedDescription)
                return
            }
            showSuccessSnackbar(message: "Sign up successful!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.popToRootViewController(animated: true)
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
    
    private func setupConfirmPasswordVisibilityButton() {
        confirmPasswordTF.isSecureTextEntry = true
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let eyeImage = UIImage(systemName: "eye", withConfiguration: configuration)
        
        let button = UIButton(type: .system)
        button.setImage(eyeImage, for: .normal)
        button.tintColor = .lightGray
        button.addAction(UIAction(handler: { _ in
            self.confirmPasswordTF.isSecureTextEntry.toggle()
            let newImage = UIImage(systemName: self.confirmPasswordTF.isSecureTextEntry ? "eye" : "eye.slash", withConfiguration: configuration)
            button.setImage(newImage, for: .normal)
        }), for: .touchUpInside)
        
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        
        confirmPasswordTF.rightView = button
        confirmPasswordTF.rightViewMode = .always
        confirmPasswordVisibilityButton = button
    }
    
}
