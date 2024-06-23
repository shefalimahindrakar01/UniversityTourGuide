//
//  ViewController.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 15/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the view controller by its identifier
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC {
            
            // Present the view controller
            self.present(signUpVC, animated: true, completion: nil)
        }
    }
    
}

