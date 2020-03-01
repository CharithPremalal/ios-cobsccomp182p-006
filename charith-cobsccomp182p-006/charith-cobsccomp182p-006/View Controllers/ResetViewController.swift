//
//  ResetViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/24/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit
import FirebaseAuth


class ResetViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    //  @IBOutlet weak var errorLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements(){
        
        errorLbl.alpha = 0
        Utilities.styleTextField(emailTxt)
        Utilities.styleFilledButton(resetBtn)
        
    }
    
    func validateFields() -> String? {
        
        if  emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
        
        return nil
    }

    @IBAction func resetPasswordTapped(_ sender: Any) {
      
        let email = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                self.errorLbl.text = error!.localizedDescription
            }
        }
    }
    
   func showError(_ message:String){
        errorLbl.text = message
        errorLbl.alpha = 1
    }
    
    

}
