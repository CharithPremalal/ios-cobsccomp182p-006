//
//  SignUpViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/19/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    var imagePicker:UIImagePickerController!
    
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

    func validateFields() -> String? {
        
        if firstNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            
        {
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false
        
        {
            return "Password must contain 8 characters and a number"
        }
        
        if  passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) != confirmPasswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        {
            return "Passwords doesn't match"
        }
        
        return nil
    }

    
    @IBAction func signUpTapped(_ sender: Any) {
        //validation
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            
            //new versions of data
            let firstName = firstNameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //user creation
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Error creating user")
                }
                else {
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid ).setData(["firstname":firstName, "lastname":lastName,
                    "phone":phone, "uid":result!.user.uid ]) { (error) in
                                                                
                     if error != nil {
                        self.showError("Error while saving data")
                                    }
                                                                
                    }
                    //transition to the home
                    self.transitionToHome()
                    
                }
            }
        }
    }
    
    
    func showError(_ message:String){
        errorLbl.text = message
        errorLbl.alpha = 1
    }
    
    func transitionToHome(){
        
        let homeViewContoller = storyboard?.instantiateViewController(withIdentifier:Constants.Storyboard.homeViewController) as? UITabBarController
        
        view.window?.rootViewController = homeViewContoller
        view.window?.makeKeyAndVisible()
    }
    
}
