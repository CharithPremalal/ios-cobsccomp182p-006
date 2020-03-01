//
//  TableViewCell.swift
//  charith-cobsccomp182p-006
//
//  Created by Charith Lakshitha on 2/27/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var EventImg: UIImageView!
    
    @IBOutlet weak var EventTitle: UILabel!
    
    @IBOutlet weak var EventDesc: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
