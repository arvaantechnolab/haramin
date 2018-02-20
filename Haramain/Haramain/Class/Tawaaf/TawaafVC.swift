//
//  TawaafVC.swift
//  Haramain
//
//  Created by Arvaan on 01/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
import SJSwiftSideMenuController

class TawaafVC: UIViewController {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var btnLeftMenu:UIButton!
    @IBOutlet weak var btnRightMenu:UIButton!
    @IBOutlet weak var btnStart:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnStart.layer.cornerRadius = 3
        btnStart.layer.masksToBounds = true
        
        if languageDefault == 0 {
            btnLeftMenu.isHidden = false
            btnRightMenu.isHidden = true
        }else {
            btnRightMenu.isHidden = false
            btnLeftMenu.isHidden = true
        }
        
        self.navigationController?.isNavigationBarHidden = true
        

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLeftClick(_ sender: Any){
        SJSwiftSideMenuController.toggleLeftSideMenu()
    }
    @IBAction func btnRightClick(_ sender: Any){
        SJSwiftSideMenuController.toggleRightSideMenu()
    }
    @IBAction func btnStartClick(_ sender: Any){
        let TawaafCounterVC = self.storyboard?.instantiateViewController(withIdentifier: "TawaafCounterVC")
        self.present(TawaafCounterVC!, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
