//
//  SideMenuVC.swift
//  SideMenuDemo
//
//  Created by Arvaan on 22/01/18.
//  Copyright © 2018 Arvaan. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController
import MessageUI

class SideMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate  {
    @IBOutlet weak var lblPlayingName: UILabel!
    
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet weak var lblPlayingTitle: UILabel!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var ivHaramainIcon: UIImageView!
    
    var menuItems : NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        menuTableView.bounces = false
     
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menuTableView.allowsSelection = true
        menuTableView.isUserInteractionEnabled = true
        self.view.backgroundColor = UIColor.clear
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idstr = "cell"
        
        var cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: idstr)!
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: idstr)
        }
        let monthName = menuItems.object(at: indexPath.row) as? String
        cell.textLabel?.text = monthName
      
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SJSwiftSideMenuController.hideLeftMenu()
        SJSwiftSideMenuController.hideRightMenu()
        
        let title = menuItems[indexPath.row]
        
        if indexPath.row == 0 {
            //Home
            let destVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
            SJSwiftSideMenuController.pushViewController(destVC!, animated: true)
        }else if indexPath.row == 1 {
            //About Us
            let CMSVC = self.storyboard?.instantiateViewController(withIdentifier: "CMSViewController") as! CMSViewController
            CMSVC.strTitle = title as! String
            SJSwiftSideMenuController.pushViewController(CMSVC, animated: true)            
        }else if indexPath.row == 2 {
            //Favourites
        }else if indexPath.row == 3 {
            //Prayer Times
            let destVC = self.storyboard?.instantiateViewController(withIdentifier: "PrayerVC")
            SJSwiftSideMenuController.pushViewController(destVC!, animated: true)
        }else if indexPath.row == 4 {
            //Makkah Daily Salaah
            let immam = self.storyboard?.instantiateViewController(withIdentifier:"makkahMadinahDailySalahList") as! makkahMadinahDailySalahList
            immam.catID = "1"
            SJSwiftSideMenuController.pushViewController(immam, animated: true)
        }else if indexPath.row == 5 {
            //Madeenah Daily Salah
            let immam = self.storyboard?.instantiateViewController(withIdentifier:"makkahMadinahDailySalahList") as! makkahMadinahDailySalahList
            immam.catID = "2"
            SJSwiftSideMenuController.pushViewController(immam, animated: true)
        }else if indexPath.row == 6 {
            //Imaams Schedule
            let GPSPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: "ImaamsScheduleVC") as! ImaamsScheduleVC
            let visibleVC =  UIApplication.shared.keyWindow!.rootViewController!
            visibleVC.addChildViewController(GPSPopUpVC)
            GPSPopUpVC.view.bounds = UIScreen.main.bounds
            visibleVC.view.addSubview(GPSPopUpVC.view)
            GPSPopUpVC.didMove(toParentViewController: self)
            
        }else if indexPath.row == 7 {
            //Read Qu'an
            let GPSPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: "DynamicPopUP") as! DynamicPopUP
            let visibleVC =  UIApplication.shared.keyWindow!.rootViewController!
            visibleVC.addChildViewController(GPSPopUpVC)
            GPSPopUpVC.view.bounds = UIScreen.main.bounds
            visibleVC.view.addSubview(GPSPopUpVC.view)
            GPSPopUpVC.didMove(toParentViewController: self)
            
            
        }else if indexPath.row == 8 {
            let email = "support@haramain.com"

            //Contact us
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients([email])
            composeVC.setSubject("")
            //composeVC.setMessageBody("Hello from California!", isHTML: false)
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(composeVC, animated: true, completion: nil)
            }            
        }
  
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
}
extension CGFloat {
    public static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    public static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

