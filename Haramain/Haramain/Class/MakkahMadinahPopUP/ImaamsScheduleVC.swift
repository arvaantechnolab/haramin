//
//  ImaamsScheduleVC.swift
//  Haramain
//
//  Created by Arvaan Techno-lab Pvt Ltd on 19/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController
class ImaamsScheduleVC: UIViewController {

    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var lblAlHaram: UILabel!
    @IBOutlet weak var lblAlNabawi: UILabel!
    @IBOutlet weak var imgViewAlHaramIcon: UIImageView!
    @IBOutlet weak var imgViewAlNabawiIcon: UIImageView!
    @IBOutlet weak var btnAlHaram: UIButton!
    @IBOutlet weak var btnAlNabawi: UIButton!
    
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        imgViewAlHaramIcon.image = UIImage(named:"uncheck")
        imgViewAlNabawiIcon.image = UIImage(named:"uncheck")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchHappen(_:)))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if languageDefault == 0 {
            //English
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            lblAlHaram.textAlignment = .left
            lblAlNabawi.textAlignment = .left
        } else {
            //Arabic
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            lblAlHaram.textAlignment = .right
            lblAlNabawi.textAlignment = .right
        }
    }
    
    @IBAction func optionTapped(_ sender: UIButton) {

        let immam = self.storyboard!.instantiateViewController(withIdentifier:"ShowImageVC") as! ShowImageVC
        if sender == btnAlHaram {
            immam.catID = "1"
        }
        else {
            immam.catID = "2"
        }
        let visibleVC =  UIApplication.shared.keyWindow!.rootViewController!
        print(visibleVC)
        SJSwiftSideMenuController.pushViewController(immam, animated: true)
        dismissViewController()
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
