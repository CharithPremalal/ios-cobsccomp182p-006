//
//  LogInViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/19/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        errorLbl.alpha = 0
        
        Utilities.styleTextField(emailTxt)
        Utilities.styleTextField(passwordTxt)
        Utilities.styleFilledButton(logInBtn)
        
    }
    
    func validateFields() -> String? {
        
        if  emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }

        return nil
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        //Validation
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
        
        //
        let email=emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password=passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Signin
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil{
                self.errorLbl.text = error!.localizedDescription
                self.errorLbl.alpha = 1
            }
            else{
                let homeViewContoller = self.storyboard?.instantiateViewController(withIdentifier:Constants.Storyboard.homeViewController) as? UITabBarController
                
                self.view.window?.rootViewController = homeViewContoller
                self.view.window?.makeKeyAndVisible()
                }
            }
        }
        
        
    }
    
    func showError(_ message:String){
        errorLbl.text = message
        errorLbl.alpha = 1
    }
    
}
