//
//  Utilities.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/12/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width , height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 52/255, green: 152/255, blue: 219/255, alpha: 1).cgColor
 //textfield.frame.width
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
        textfield.textColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    
}
