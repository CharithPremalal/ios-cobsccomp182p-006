//
//  Event.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/27/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import Foundation
import  UIKit

class Cell{
    
    var EventImg : UIImage
    var EventTitle: String
    var EventDesc: String
    
    
    init(EventImg: UIImage , EventTitle:String , EventDesc:String ) {
        
        self.EventImg = EventImg
        self.EventTitle = EventTitle
        self.EventDesc = EventDesc
     
    }
}
