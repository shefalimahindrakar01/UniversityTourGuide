//
//  ViewController.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 15/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupUI() {
        self.view.applyGradient(colors: [UIColor.primaryColor, UIColor.secondaryColor, UIColor.tertiaryColor])
        
        let borderColor = UIColor.white
        let borderWidth: CGFloat = 1.0
        let cornerRadius: CGFloat = 10.0
        
        btnSignIn.customizeBorderAndCornerRadius(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius)
        btnSignUp.customizeBorderAndCornerRadius(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius)
    }
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as? SignInVC {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
}
