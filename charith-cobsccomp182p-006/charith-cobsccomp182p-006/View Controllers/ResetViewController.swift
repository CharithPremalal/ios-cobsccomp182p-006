//
//  ResetViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/24/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit


class ResetViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
  //  @IBOutlet weak var errorLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements(){
        
        Utilities.styleTextField(emailTxt)
        Utilities.styleFilledButton(resetBtn)
        
    }
    
    @IBAction func resetPasswordTapped(_ sender: Any) {
       
        
    }
    
  /*  func showError(_ message:String){
        errorLbl.text = message
        errorLbl.alpha = 1
    }*/
    
    

}
