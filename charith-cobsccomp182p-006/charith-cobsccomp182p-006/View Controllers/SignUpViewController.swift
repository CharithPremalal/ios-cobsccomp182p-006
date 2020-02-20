//
//  SignUpViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/19/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        
        errorLbl.alpha = 0
        
        Utilities.styleTextField(firstNameTxt)
        Utilities.styleTextField(lastNameTxt)
        Utilities.styleTextField(emailTxt)
        Utilities.styleTextField(phoneNumber)
        Utilities.styleTextField(passwordTxt)
        Utilities.styleTextField(confirmPasswordTxt)
        Utilities.styleFilledButton(signUpBtn)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func signUpTapped(_ sender: Any) {
        
    }
    
}
