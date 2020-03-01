//
//  ProfileViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/25/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLoggedInUserStatus()
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func checkLoggedInUserStatus(){
        if Auth.auth().currentUser == nil{
            
            DispatchQueue.main.async {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                self.present(vc, animated: true, completion: nil)
                
                return
            }
        }else{
            
          print("user Logged")
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