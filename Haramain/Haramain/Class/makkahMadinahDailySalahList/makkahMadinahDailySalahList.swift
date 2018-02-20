//
//  MakkahDailySalaahVC.swift
//  Haramain
//
//  Created by naman on 15/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
class makkahMadinahDailySalahList: UIViewController {
   // var makkah : MakkahMadinahListBaseClass?
    var catID = ""
    var makkahData = Array<JSON>()
     var madinah = Array<JSON>()
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var tblMakkah: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let nib = UINib(nibName: "GpsLightCell", bundle: nil)
        tblMakkah.register(nib, forCellReuseIdentifier: "GpsLightCell")
        
        getMakkahDailySalaah()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMakkahDailySalaah(){
        SVProgressHUD.show()
        getDataFromUrl(url: finalUrl.haramainDaily, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
            var arr = Array<JSON>()
            arr = json.arrayValue
            
            //make makkah array
            for index in 0..<arr.count - 1 {
                if arr[index]["location_id"] == (self.catID == "1" ? 1 : 2) {
                    self.makkahData.append(arr[index])
                }else {
                    self.madinah.append(arr[index])
                }
            }
            
            
            print(self.makkahData.count)
            
            print(self.makkahData.debugDescription)
            
            self.tblMakkah.reloadData()
          
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension makkahMadinahDailySalahList: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        if catID == "1" {
           return self.makkahData.count + 1
        }else {
            return self.madinah.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GpsLightCell", for: indexPath) as! GpsLightCell
        if indexPath.row == 0 {
            cell.lblGpsLight.text = catID == "1" ? "LATEST FROM MAKKAH" : "LATEST FROM MADINAH"
            cell.lblGpsLight.textColor = UIColor.white
            if #available(iOS 10.0, *) {
                cell.viewBackground.backgroundColor = UIColor(displayP3Red: 27/255.0, green: 60/255.0, blue: 50/255.0, alpha: 1.0)
            } else {
                // Fallback on earlier versions
                cell.viewBackground.backgroundColor = UIColor(red: 27/255.0, green: 60/255.0, blue: 50/255.0, alpha: 1.0)
                
                
            }
        }else {
            
            if catID == "1" {
                cell.lblGpsLight.text =  languageDefault == 0 ? String(describing:self.makkahData[indexPath.row - 1]["name"]) : String(describing:self.makkahData[indexPath.row - 1]["name_ar"])
            }else {
                cell.lblGpsLight.text = languageDefault == 0 ? String(describing:self.madinah[indexPath.row - 1]["name"])  : String(describing:self.madinah[indexPath.row - 1]["name"])
            }
            
            
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let makkahPlayList = self.storyboard?.instantiateViewController(withIdentifier: "MakkahMadinahPlayingListVC") as! MakkahMadinahPlayingListVC
        if indexPath.row == 0 {
            makkahPlayList.catID = catID
            makkahPlayList.subCatID = ""
            self.navigationController?.pushViewController(makkahPlayList, animated: true)
        }else {
            makkahPlayList.catID = catID
            makkahPlayList.subCatID = catID == "1" ? String(describing:self.makkahData[indexPath.row - 1]["id"]) : String(describing:self.madinah[indexPath.row - 1]["id"])
            self.navigationController?.pushViewController(makkahPlayList, animated: true)
        }
   
   
    }
    
}

