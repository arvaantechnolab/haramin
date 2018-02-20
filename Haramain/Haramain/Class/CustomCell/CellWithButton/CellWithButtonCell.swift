//
//  CellWithButtonCell.swift
//  Haramain
//
//  Created by naman on 03/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class CellWithButtonCell: UITableViewCell {

   
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
