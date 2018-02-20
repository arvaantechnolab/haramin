//
//  ViewController.swift
//  Haramain
//
//  Created by naman on 07/01/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import SJSwiftSideMenuController

class ViewController: UIViewController {

    @IBOutlet weak var viewSocial: UIView!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnTwiter: UIButton!
    @IBOutlet weak var btnYouTube: UIButton!
    @IBOutlet weak var btnInstaGram: UIButton!
    @IBOutlet weak var btnSnapChat: UIButton!
    @IBOutlet weak var btnMail: UIButton!
    @IBOutlet weak var btnWeb: UIButton!
    @IBOutlet weak var imgView: UIView!
    
    @IBOutlet weak var haramBaseView: UIView!
    @IBOutlet weak var ivHaram: UIImageView!
    @IBOutlet weak var lblHaram: UILabel!
    
    @IBOutlet weak var nabawiView: UIView!
    @IBOutlet weak var ivNabawi: UIImageView!
    @IBOutlet weak var lblNabawi: UILabel!
    
    @IBOutlet weak var gpsView: UIImageView!
    @IBOutlet weak var ivGps: UIImageView!
    
    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var ivGallery: UIImageView!
    @IBOutlet weak var lblGallery: UILabel!

    
    @IBOutlet weak var btnArabic: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var lblGps: UILabel!
    
    @IBOutlet weak var btnMenuLeft: UIButton!
    @IBOutlet weak var btnMenuRight: UIButton!
    
    @IBOutlet weak var btnHaram: UIButton!
    @IBOutlet weak var btnNabawi: UIButton!
    @IBOutlet weak var btnGps: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.getMosqueList()
        
        if languageDefault == 0 {
            btnMenuLeft.isHidden = false
            btnMenuRight.isHidden = true
        }else {
            btnMenuRight.isHidden = false
            btnMenuLeft.isHidden = true
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnArabic.layer.cornerRadius = self.btnArabic.layer.frame.size.height/2
        self.btnArabic.clipsToBounds = true
        
        
        self.btnEnglish.layer.cornerRadius = self.btnArabic.layer.frame.size.height/2
        self.btnEnglish.clipsToBounds = true
    }
    
    func getMosqueList(){
        SVProgressHUD.show()
        getDataFromUrl(url: finalUrl.mosqueList, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
             SVProgressHUD.dismiss()
           let model = MosqueBaseClass(json: json)
            appDelegate.mosqueMainModel = nil
            appDelegate.mosqueMainModel = model
           
            if appDelegate.mosqueMainModel!.data!.galleryKey!.count != 0 {
                 self.makeNecessaryViewSetting()
            }
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    func makeNecessaryViewSetting() {
        switch languageDefault {
        case 0:
            ivHaram.sd_setImage(with:URL(string:appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage![0]), completed: nil)
            lblHaram.text = appDelegate.mosqueMainModel!.data!.masjidAlHaram!.categoryName!
            ivNabawi.sd_setImage(with: URL(string: appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage![0]), completed: nil)
            lblNabawi.text = appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.categoryName!
            lblGallery.text = languageLabel.galleryImage
            lblGps.text = languageLabel.haramainGpsImage
            
        case 1 :
            ivHaram.sd_setImage(with:URL(string:appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage![0]), completed: nil)
            lblHaram.text = appDelegate.mosqueMainModel!.data!.masjidAlHaram!.categoryName!
            ivNabawi.sd_setImage(with: URL(string: appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage![0]), completed: nil)
            lblNabawi.text = appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.categoryName!
            lblGallery.text = languageLabel.gallery
            lblGps.text = languageLabel.haramainGps
        default: break
            
        }
    }
    
    @IBAction func btnFaceBookClicked(_ sender: Any) {
        openSocialPage(url: "https://www.facebook.com/haramain.info/")
    }
    
    @IBAction func btnTwitterClicked(_ sender: Any) {
        openSocialPage(url: "https://twitter.com/HaramainInfo")
    }
    
    @IBAction func btnYoutubeClicked(_ sender: Any) {
        openSocialPage(url: "https://www.youtube.com/user/haramaininfo")
    }
    
    @IBAction func btnInstagramClicked(_ sender: Any) {
        openSocialPage(url: "https://www.instagram.com/haramain_info/")
    }
    
    @IBAction func btnSnapClicked(_ sender: Any) {
        openSocialPage(url: "https://www.snapchat.com/add/haramaininfo")
    }
    
    @IBAction func btnMailClicked(_ sender: Any) {
        
    }
    
    @IBAction func btnWebClicked(_ sender: Any) {
        openSocialPage(url: "http://www.haramain.info")
    }
    
    func openSocialPage(url: String) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func btnArabicClicked(_ sender: Any) {
        languageDefault = 1
        btnMenuLeft.isHidden = true
        btnMenuRight.isHidden = false
        self.getMosqueList()
    }
    
    @IBAction func btnEnglishClicked(_ sender: Any) {
        languageDefault = 0
        btnMenuRight.isHidden = true
        btnMenuLeft.isHidden = false
        self.getMosqueList()
    }
    @IBAction func btnMenuLeftClick(_ sender: Any) {
          SJSwiftSideMenuController.toggleLeftSideMenu()
    }
    
    @IBAction func btnMenuRightClick(_ sender: Any) {
          SJSwiftSideMenuController.toggleRightSideMenu()
    }
    
    
    @IBAction func btnHaramClicked(_ sender: Any) {
        let haramVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCategoryVC") as! SelectCategoryVC
        haramVC.catID = "1"
        self.navigationController?.pushViewController(haramVC, animated: true)
    }
    @IBAction func btnNabawi(_ sender: Any) {
        let haramVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCategoryVC") as! SelectCategoryVC
        haramVC.catID = "2"
        self.navigationController?.pushViewController(haramVC, animated: true)
    }
    @IBAction func btnGpsClicked(_ sender: Any) {
        let GPSPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: "GPSPopUpVC") as! GPSPopUpVC
        let visibleVC =  self.navigationController?.topViewController
        visibleVC?.addChildViewController(GPSPopUpVC)
        GPSPopUpVC.view.bounds = self.view.bounds
        visibleVC?.view.addSubview(GPSPopUpVC.view)
        GPSPopUpVC.didMove(toParentViewController: self)
    }
    @IBAction func btnGalleryClicked(_ sender: Any) {
    }
    
}

