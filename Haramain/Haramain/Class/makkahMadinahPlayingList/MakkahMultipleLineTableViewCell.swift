//
//  MakkahMultipleLineTableViewCell.swift
//  Haramain
//
//  Created by naman on 19/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class MakkahMultipleLineTableViewCell: UITableViewCell {
    @IBOutlet var lblSuraText: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSingerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
