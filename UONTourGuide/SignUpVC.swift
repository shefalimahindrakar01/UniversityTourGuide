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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
//        signUp(email: userNameTF.text ?? "", password: passwordTF.text ?? "") { success, error in
//            print(self.userNameTF.text)
//            print(self.passwordTF.text)
//            if success {
//                print("User signed up successfully")
//                // Navigate to another screen or show success message
//            } else {
//                print("Sign up error: \(error ?? "Unknown error")")
//                // Show error message
//            }
//        }
        
        signIn(email: userNameTF.text ?? "", password: passwordTF.text ?? "") { success, error in
                if success {
                    print("User signed in successfully")
                    // Navigate to another screen or show success message
                } else {
                    print("Sign in error: \(error ?? "Unknown error")")
                    // Show error message
                }
            }
    }
        
        func signUp(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(false, error.localizedDescription)
                    return
                }
                completion(true, nil)
            }
        }
        
        func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(false, error.localizedDescription)
                    return
                }
                completion(true, nil)
            }
        }
        
        
    }

