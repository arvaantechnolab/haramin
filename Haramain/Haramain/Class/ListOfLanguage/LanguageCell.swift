//
//  LanguageCell.swift
//  Haramain
//
//  Created by naman on 11/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var ivLanguage: UIImageView!
    @IBOutlet weak var lblLanguageTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
