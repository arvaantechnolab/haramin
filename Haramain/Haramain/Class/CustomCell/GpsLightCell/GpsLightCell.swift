//
//  GpsLightCell.swift
//  Haramain
//
//  Created by naman on 03/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class GpsLightCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblGpsLight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if languageDefault == 1 {
            lblGpsLight.textAlignment = .right
           
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
