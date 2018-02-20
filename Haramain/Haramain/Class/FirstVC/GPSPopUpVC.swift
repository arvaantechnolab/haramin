//
//  GPSPopUpVC.swift
//  Haramain
//
//  Created by Arvaan Techno-lab Pvt Ltd on 19/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class GPSPopUpVC: UIViewController {

    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    @IBOutlet weak var btnOption4: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(touchHappen(_:)))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
    }
    
    @IBAction func btnOptionTapped(_ sender: UIButton) {
        var catID = "0"
        switch sender {
        case btnOption1:
            catID = "1"
            break
        case btnOption2:
            catID = "2"
            break
        case btnOption3:
            catID = "3"
            break
        case btnOption4:
            break
        default:
            break
        }
        
        if catID != "0" {
            let gpsVC = self.storyboard?.instantiateViewController(withIdentifier:"GpsHeadingVC") as! GpsHeadingVC
            gpsVC.catID = catID
            self.navigationController?.pushViewController(gpsVC, animated: true)
            dismissViewController()
        }
    }
    
    @objc func touchHappen(_ sender: UITapGestureRecognizer) {
        dismissViewController()
    }
    
    func dismissViewController() {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }


}
