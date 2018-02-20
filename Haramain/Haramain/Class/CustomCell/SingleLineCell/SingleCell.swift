//
//  SingleCell.swift
//  Haramain
//
//  Created by naman on 03/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class SingleCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if languageDefault == 1 {
            lblName.textAlignment = .right
          
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
