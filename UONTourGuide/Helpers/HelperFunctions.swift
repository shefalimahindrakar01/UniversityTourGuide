//
//  HelperFunctions.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/07/24.
//

import UIKit
import TTGSnackbar
import SVProgressHUD

public func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

public func showErrorSnackbar(message: String) {
    let snackbar = TTGSnackbar(message: message, duration: .middle)
    snackbar.backgroundColor = .black
    snackbar.show()
}

public func showSuccessSnackbar(message: String) {
    let snackbar = TTGSnackbar(message: message, duration: .middle)
    snackbar.backgroundColor = .black
    snackbar.show()
}

public func showLoadingIndicator() {
    SVProgressHUD.show()
}

public func hideLoadingIndicator() {
    SVProgressHUD.dismiss()
}
