//
//  SelectCategoryVC.swift
//  Haramain
//
//  Created by naman on 05/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController
import SVProgressHUD
class SelectCategoryVC: UIViewController {
    
    @IBOutlet weak var scrollviewImages: UIScrollView!
    @IBOutlet weak var ivMasij: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ViewNameOfCategory: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var bottomConstrain: NSLayoutConstraint!
    var timer : Timer!
    var catID = ""
    var imageArray : [URL] = []
    var arrNawabi = ["LIVE Friday Khutbahs with Translation","Watch Masjid An Nabawi LIVE","Listen to Masjid An Nabawi LIVE","Daily Salaah Recordings","Imaams Qur'an Recitation","Previous Taraweeh Salaah","Khutbahs With Translation","Muadhins / Adhaan" , "Madeenah Prayer Times","GPS Masjid An Nabawi", "Masjid An Nabawi Images","Imaams Schedule","Khateeb Schedule","Ziyaarah Times For Women","Read Qu'an"]
  
    var arrHaram = ["Watch Masjid Al Haram LIVE","Listen to Masjid Al Haram LIVE","Daily Salaah Recordings","Imaams Qur'an Reciation","Previous Tareweeh Salaah","Khutbahs With Translation","Muadhins/Adhaan","Makkah Prayer Times","GPS Masjid Al Haram","Tawaaf Counter","Masjid Al Haram Images","Imaams Schedule","Khateeb Schedule","Read Qu'an"]
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CellWithButtonCell", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "CellWithButtonCell")
        
        self.navigationController?.isNavigationBarHidden = true
        if catID == "1" {
            lblName.text = appDelegate.mosqueMainModel!.data!.masjidAlHaram!.categoryName
            pageControl.numberOfPages =  appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage!.count
            let urlString = appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage![pageControl.currentPage]
            for str in appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage! {
                imageArray.append(URL(string: str)!)
            }
        }else {
            lblName.text = appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.categoryName
            pageControl.numberOfPages =  appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage!.count
            let urlString = appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage![pageControl.currentPage]
            for str in appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage! {
                imageArray.append(URL(string: str)!)
            }
        }
       
        
        ivMasij.sd_setAnimationImages(with: imageArray)
        ivMasij.animationDuration = 100
        
        pageControl.currentPage = 0
        // timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(setAnimaton), userInfo: nil, repeats: true)
        
        if languageDefault == 0 {
            btnLeft.isHidden = false
            btnRight.isHidden = true
        }else {
            btnRight.isHidden = false
            btnLeft.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        //print("Timer Stoped")
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    @IBAction func btnLeftClicked(_ sender: Any) {
        SJSwiftSideMenuController.toggleLeftSideMenu()
    }
    
    @IBAction func btnRightClicked(_ sender: Any) {
        SJSwiftSideMenuController.toggleRightSideMenu()
    }
    
    // MARK: - Update images
    @objc func setAnimaton() {
        hideAnimation()
        if pageControl.currentPage == pageControl.numberOfPages {
            pageControl.currentPage = 0
        }else {
            pageControl.currentPage = pageControl.currentPage + 1
        }
        let urlString = appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage![pageControl.currentPage]
        //ivMasij.sd_setAnimationImages(with: <#T##[URL]#>)
        showAnimation()
    }
    
    func hideAnimation() {
        self.bottomConstrain.constant = 0
        UIView.animate(withDuration: 0.5 ,animations: {
            self.ViewNameOfCategory.isHidden = false
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options:UIViewAnimationOptions.curveEaseIn, animations: {
                self.bottomConstrain.constant = -15
            }) { _ in
                self.bottomConstrain.constant = -31
            }
        })
    }
    
    func showAnimation(){
        self.bottomConstrain.constant = -31
        UIView.animate(withDuration: 0.5 ,animations: {
            self.ViewNameOfCategory.isHidden = false
            
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options:UIViewAnimationOptions.curveEaseOut, animations: {
                self.bottomConstrain.constant = -15
            }) { _ in
                self.bottomConstrain.constant = 0
                
            }
        })
    }
    
    
}
extension SelectCategoryVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if catID == "1" {
            return arrHaram.count
        }else if catID == "2" {
            return arrNawabi.count
        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithButtonCell", for: indexPath) as! CellWithButtonCell
        if catID == "1" {
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
                if #available(iOS 10.0, *) {
                    cell.viewButton.backgroundColor = UIColor(displayP3Red: 50/255.0, green: 86/255.0, blue: 75/255.0, alpha: 1.0)
                } else {
                    // Fallback on earlier versions
                    cell.viewButton.backgroundColor = UIColor(red: 50/255.0, green: 86/255.0, blue: 75/255.0, alpha: 1.0)
                }
                cell.lblName.textColor = UIColor.white
            }else {
                cell.viewButton.backgroundColor = UIColor.white
                cell.lblName.textColor = UIColor.black
            }
            
            cell.lblName.text = String(describing: arrHaram[indexPath.row])
        }else {
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
                if #available(iOS 10.0, *) {
                    cell.viewButton.backgroundColor = UIColor(displayP3Red: 5/255.0, green: 86/255.0, blue: 75/255.0, alpha: 1.0)
                } else {
                    // Fallback on earlier versions
                    cell.viewButton.backgroundColor = UIColor(red: 50/255.0, green: 86/255.0, blue: 75/255.0, alpha: 1.0)
                }
                 cell.lblName.textColor = UIColor.white
            }else {
                cell.viewButton.backgroundColor = UIColor.white
                cell.lblName.textColor = UIColor.black
            }
            cell.lblName.text = String(describing: arrNawabi[indexPath.row])
        }
       
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if catID == "1" {
            if indexPath.row == 0 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"YouTubeVC") as! YouTubeVC
                appDelegate.player.pause()
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 1 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"SinglePlayVC") as! SinglePlayVC
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 2 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"makkahMadinahDailySalahList") as! makkahMadinahDailySalahList
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 3 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"SelectImaam") as! SelectImaam
                immam.catID = catID
                immam.subCatID = "7"
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 4 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"PreviousTaraweehVC") as! PreviousTaraweehVC
                immam.catID = catID
                immam.subCatID = "8"
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 5 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"KhutbahsVC") as! KhutbahsVC
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 6 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"MuadhinsVC") as! MuadhinsVC
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 7 {
                let prayerVC = self.storyboard?.instantiateViewController(withIdentifier:"PrayerVC") as! PrayerVC
                self.navigationController?.pushViewController(prayerVC, animated: true)
            }else if indexPath.row == 8 {
                let gpsVC = self.storyboard?.instantiateViewController(withIdentifier:"GpsHeadingVC") as! GpsHeadingVC
                gpsVC.catID = catID
                gpsVC.titleText = "GPS Masjid Al Haram"
                self.navigationController?.pushViewController(gpsVC, animated: true)
            }else if indexPath.row == 9 {
                let taraf = self.storyboard?.instantiateViewController(withIdentifier:"TawaafVC") as! TawaafVC
                self.navigationController?.pushViewController(taraf, animated: true)
            }else if indexPath.row == 10 {
                let imgView = self.storyboard?.instantiateViewController(withIdentifier:"ShowImageVC") as! ShowImageVC
                imgView.catID = catID
                imgView.subCatId = ""
                self.navigationController!.pushViewController(imgView, animated: true)
            }else if indexPath.row == 11 {
                let imgView = self.storyboard?.instantiateViewController(withIdentifier:"ShowImageVC") as! ShowImageVC
                imgView.subCatId = appDelegate.mosqueMainModel!.data!.galleryKey![2].subCategory![0].galleryCategoryId!
                imgView.catID = catID
                self.navigationController?.pushViewController(imgView, animated: true)
            }else if indexPath.row == 12 {
                let imgView = self.storyboard?.instantiateViewController(withIdentifier:"ShowImageVC") as! ShowImageVC
                imgView.subCatId = appDelegate.mosqueMainModel!.data!.galleryKey![3].galleryCategoryId!
                imgView.catID = catID
                self.navigationController?.pushViewController(imgView, animated: true)
            }
        }else {
            if indexPath.row == 1 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"YouTubeVC") as! YouTubeVC
                appDelegate.player.pause()
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 2 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"SinglePlayVC") as! SinglePlayVC
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 3 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"makkahMadinahDailySalahList") as! makkahMadinahDailySalahList
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 4 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"SelectImaam") as! SelectImaam
                immam.catID = catID
                immam.subCatID = "16"
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 5 {
                
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"PreviousTaraweehVC") as! PreviousTaraweehVC
                immam.catID = catID
                immam.subCatID = "17"
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 6 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"KhutbahsVC") as! KhutbahsVC
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 7 {
                let immam = self.storyboard?.instantiateViewController(withIdentifier:"MuadhinsVC") as! MuadhinsVC
                immam.catID = catID
                self.navigationController?.pushViewController(immam, animated: true)
            }else if indexPath.row == 8 {
                let prayerVC = self.storyboard?.instantiateViewController(withIdentifier:"PrayerVC") as! PrayerVC
                self.navigationController?.pushViewController(prayerVC, animated: true)
            }else if indexPath.row == 9 {
                let gpsVC = self.storyboard?.instantiateViewController(withIdentifier:"GpsHeadingVC") as! GpsHeadingVC
                gpsVC.catID = catID
                 gpsVC.titleText = "GPS Masjid An Nabawi"
                self.navigationController?.pushViewController(gpsVC, animated: true)
            }else if indexPath.row == 10 {
                let imgView = self.storyboard?.instantiateViewController(withIdentifier:"ShowImageVC") as! ShowImageVC
                imgView.catID = catID
                imgView.subCatId = ""
                self.navigationController!.pushViewController(imgView, animated: true)
            }else if indexPath.row == 11 {
                let imgView = self.storyboard?.instantiateViewController(withIdentifier:"ShowImageVC") as! ShowImageVC
                imgView.subCatId = appDelegate.mosqueMainModel!.data!.galleryKey![2].subCategory![1].galleryCategoryId!
                imgView.catID = catID
                self.navigationController?.pushViewController(imgView, animated: true)
            }else if indexPath.row == 12 {
                let imgView = self.storyboard?.instantiateViewController(withIdentifier:"ShowImageVC") as! ShowImageVC
                imgView.subCatId = appDelegate.mosqueMainModel!.data!.galleryKey![3].galleryCategoryId!
                imgView.catID = catID
                self.navigationController?.pushViewController(imgView, animated: true)
            }else if indexPath.row == 13 {
                let imgView = self.storyboard?.instantiateViewController(withIdentifier:"ShowImageVC") as! ShowImageVC
                imgView.subCatId = appDelegate.mosqueMainModel!.data!.galleryKey![4].galleryCategoryId!
                imgView.catID = catID
                self.navigationController?.pushViewController(imgView, animated: true)
            }
        }
        
        
       
        self.tblView.deselectRow(at: indexPath, animated: true)
    }
    
}
