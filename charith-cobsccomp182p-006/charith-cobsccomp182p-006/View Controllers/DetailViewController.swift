//
//  DetailViewController.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/29/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var EventLbl: UILabel!
    @IBOutlet weak var EventDesc: UILabel!
    @IBOutlet weak var GoingBtn: UIButton!
    
    
    var Ename = ""
    var Edescription = ""
    var Eimgurl = ""
    
    func setUpElements(){
        
        Utilities.styleFilledButton(GoingBtn)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        EventLbl.text = "\(Ename)"
        EventDesc.text = "\(Edescription)"
        let imgurls = URL(string: "\(Eimgurl)")
        img.kf.setImage(with: imgurls)
        
        
    }
    
    @IBAction func GoingTapped(_ sender: Any) {
    }
    
    
}
