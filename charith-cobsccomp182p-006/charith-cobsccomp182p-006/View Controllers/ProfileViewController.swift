//
//  ProfileViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/25/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit
import FirebaseAuth
import LocalAuthentication
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {

    @IBOutlet weak var FirstName: UILabel!
    @IBOutlet weak var LastName: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Phone: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLoggedInUserStatus()
        

        // Do any additional setup after loading the view.
    }
    
    func BioLogin(){
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Message") { (good, errpr) in
            if good {
                print("good")
            }else{
                print("Try Again")
                }
            }
        }
    }
    
    
    fileprivate func checkLoggedInUserStatus(){
        if Auth.auth().currentUser == nil{
            

            DispatchQueue.main.async {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                self.present(vc, animated: true, completion: nil)
                return
            }
        }else{
            BioLogin()
            getEventOwnerName()
        }
    }
    
    func getEventOwnerName(){
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        print(uid)
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.FirstName.text = (document.get("firstname") as! String)
                self.LastName.text = (document.get("lastname") as! String)
          //      self.Email.text = (document.get("email") as! String)
                self.Phone.text = (document.get("phone") as! String)
                let profile = (document.get("profilimg") as! String)
                self.profileImg.kf.setImage(with: URL(string: profile), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)

            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func LogoutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            self.present(vc, animated: true, completion: nil)
            
        }catch let err{
            
            print("Failed to sign out with error",err)
            
            
        }
    }
}
