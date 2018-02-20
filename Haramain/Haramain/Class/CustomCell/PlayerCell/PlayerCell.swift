//
//  PlayerCell.swift
//  Haramain
//
//  Created by naman on 03/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
protocol PlayerDelegate {
    func DownLoadClick(cell : PlayerCell)
     func Favourite(cell : PlayerCell)
}
class PlayerCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    var delegatePlayer : PlayerDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnFavouriteClicked(_ sender: Any) {
        delegatePlayer?.Favourite(cell: self)
    }
    @IBAction func btnDownLoadClicked(_ sender: Any) {
        delegatePlayer?.DownLoadClick(cell: self)
    }
}
