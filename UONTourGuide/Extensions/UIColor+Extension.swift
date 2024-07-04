//
//  UIColor+Extension.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/07/24.
//

import UIKit

extension UIColor {
    
    // Convert hex string to UIColor
    convenience init(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // Primary color
    static var primaryColor: UIColor {
        return UIColor(hex: "#00AAC6")
    }
    
    // Secondary color
    static var secondaryColor: UIColor {
        return UIColor(hex: "#006E9D")
    }
    
    // Tertiary color
    static var tertiaryColor: UIColor {
        return UIColor(hex: "#0E2D72")
    }
    
    // Logo text color
    static var textColor: UIColor {
        return UIColor(hex: "#182A6B")
    }
}

