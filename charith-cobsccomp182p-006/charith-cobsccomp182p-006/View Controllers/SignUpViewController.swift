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
import  FirebaseStorage

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    var imagePicker:UIImagePickerController!
    var profileimg: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        profile()

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
            
            guard let imageSelected = self.profileimg else{
                
                print("profile image nil")
                return
            }
            
            guard let imageData = imageSelected.jpegData(compressionQuality: 0.4)else{
                
                return
            }
            
            //user creation
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Error creating user")
                }
                else {
                    
                    let storageRef = Storage.storage().reference(forURL: "gs://charith-cobsccomp182p-006.appspot.com")
                    let storageProfileRef = storageRef.child("images").child((result?.user.uid)!)
                    
                    let metadata = StorageMetadata()
                    let db = Firestore.firestore()
                      metadata.contentType = "image/jpg"
                    
                    
                  /*  db.collection("users").document(result!.user.uid ).setData(["firstname":firstName, "lastname":lastName,
                    "phone":phone, "uid":result!.user.uid ]) { (error) in
                                                                
                     if error != nil {
                        self.showError("Error while saving data")
                                    }
                                                                
                    }*/
                    
                    storageProfileRef.putData(imageData, metadata: metadata, completion: { (StorageMetadata, error) in
                        
                        if error != nil
                        {
                            print(error?.localizedDescription)
                            return
                        }
                        
                        storageProfileRef.downloadURL(completion: { (url, error) in
                            
                            if let metaImageUrl = url?.absoluteString{
                                db.collection("users").document(result!.user.uid ).setData(["firstname":firstName, "lastname":lastName,"phone":phone, "uid":result!.user.uid,"profilimg": metaImageUrl ]) { (error) in

                                    if error != nil {
                                        self.showError("Error while saving data")
                                                                                                }
                                                                                                
                                }
                                
                                print(metaImageUrl)
                            }
                        })
                        
                        
                    })
                    //transition to the home
                    self.transitionToHome()
                    
                }
            }
        }
    }
    
    func profile(){
        
        
        
        //        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImg.clipsToBounds = true
        profileImg.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pick))
        profileImg.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func pick(){
        
        let imgpicker = UIImagePickerController()
        imgpicker.sourceType = .photoLibrary
        imgpicker.allowsEditing = true
        imgpicker.delegate = self
        self.present(imgpicker, animated: true , completion: nil)
        
        
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

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            profileimg = imageSelected
            profileImg.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            profileimg = imageOriginal
            profileImg.image = imageOriginal
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
