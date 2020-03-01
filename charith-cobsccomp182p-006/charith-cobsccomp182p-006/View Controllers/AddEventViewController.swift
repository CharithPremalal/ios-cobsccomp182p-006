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
import FirebaseStorage



class AddEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
   
    var eventimage: UIImage? = nil

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
        
        guard let imageSelected = self.eventimage else{
            
            print("profile image nil")
            return
       }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4)else{
            
            return
        }
       
        
        let EventTitle = EventName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let EventDesc = EventDescTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let FirstName = EmailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let metadata = StorageMetadata()
        let database  = Firestore.firestore()
        metadata.contentType = "image/jpg"
        let storageRef = Storage.storage().reference(forURL: "gs://charith-cobsccomp182p-006.appspot.com")
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        let storageProfileRef = storageRef.child("Events")
        storageProfileRef.putData(imageData, metadata: metadata) { (StorageMetaData, error) in
            
            if error != nil
            {
                print(error?.localizedDescription)
                return
            }
            
            storageProfileRef.downloadURL(completion: { (url, error) in
                
                if let metaImageUrl = url?.absoluteString{
                    
                    database.collection("Events").document().setData(["EventTitle":EventTitle, "EventDescription": EventDesc, "FirstName": FirstName, "eventimgurl": metaImageUrl]) { (error) in
                        
                        if error != nil {
                            
                            print("error")
                        }else{
                            
                            print("done")
                            
                            let Home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                            self.present(Home, animated: true, completion: nil)
                        }
                    }
                }

            })
         
        }
        
    }
    func getEventOwnerName(){
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.EmailTxt.text = (document.get("firstname") as! String)
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            eventimage = imageSelected
            EventImage.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            eventimage = imageOriginal
            EventImage.image = imageOriginal
        }
        //
        picker.dismiss(animated: true, completion: nil)
    }
    
    func eventImage(){
        
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Select an Image", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.present(imagePickerController, animated: true , completion: nil)
            }else{
                
                //                return "Camere is Not Available"
                
                print("Camera Unavailable")
            }
            
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true , completion: nil)
    }
    
    @IBAction func AddImgTapped(_ sender: Any) {
        eventImage()
    }
    
    
    
}
