//
//  AddEventViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/26/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase



class AddEventViewController: UIViewController {
    
    
   

    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var EventImgBtn: UIButton!
    @IBOutlet weak var EventName: UITextField!
    @IBOutlet weak var EventDescTxt: UITextView!
    @IBOutlet weak var SaveEventBtn: UIButton!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        checkLoggedInUserStatus()
        getEventOwnerName()
    
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        
        errorLbl.alpha = 0
        
        Utilities.styleTextField(EventName)
        Utilities.styleFilledButton(SaveEventBtn)
        Utilities.styleFilledButton(EventImgBtn)

        
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
    
    
    @IBAction func EventSave(_ sender: Any) {
        
        EventDetails()
        
    }
    
    func EventDetails(){
        
        /*//  guard let imageSelected = self.image else{
            
            print("profile image nil")
            return
       }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4)else{
            
            return
        }
       */
        
        let EventTitle = EventName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
       // let eventDate = eventDateTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let EventDescription = EventDescTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let FirstName = EmailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
       // let EventLocation =  eventLocationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
       // let ownerId =  ownersId.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
       //  let metadata = StorageMetadata()
        
        let database  = Firestore.firestore()
       // metadata.contentType = "image/jpg"
       // let storageRef = Storage.storage().reference(forURL: "gs://event-app-93d34.appspot.com")
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
    database.collection("Events").document().setData(["EventTitle":EventTitle, "EventDescription": EventDescription, "FirstName": FirstName]) { (error) in
            
            
            if error != nil {
                
                print("error")
              //  self.showErrorMessage("Error when creating Event")
            }else{
                
                print("done")
                
               // self.redirectToHomeController()
            }
        
        }
        
        //        let docRef = database.collection("users").document()
        
       // let storageProfileRef = storageRef.child("Events")
        
        
        
        
      /*  storageProfileRef.putData(imageData, metadata: metadata) { (StorageMetaData, error) in
            
            if error != nil
            {
                print(error?.localizedDescription)
                return
            }
            
            storageProfileRef.downloadURL(completion: { (url, error) in
                
                if let metaImageUrl = url?.absoluteString{
                    
                    print(metaImageUrl)
                }
                
            })
         
        }*/
        
        
        
        
    }
    func getEventOwnerName(){
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
                //  self.eventOwnerTextField.text = (document.get("firstname") as! String)
                
                self.EmailTxt.text = (document.get("firstname") as! String)
                
                // self.eventOwnerTextField.isUserInteractionEnabled = false
                
                //  self.ownersId.isUserInteractionEnabled = false
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
}
