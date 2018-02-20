//
//  KhutbahsYearsVC.swift
//  Haramain
//
//  Created by naman on 08/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD

class KhutbahsYearsVC: UIViewController {
    var catID = ""
    var subCatID = ""
    @IBOutlet weak var tblKhutbahs: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    var previousKhutbah : PreviousKhutbahBaseClass? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getKhutbahsYears()
        let nib = UINib(nibName: "SingleCell", bundle: nil)
        tblKhutbahs.register(nib, forCellReuseIdentifier: "SingleCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    func getKhutbahsYears(){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID]
        print(parameter)
        let iMaamListUrl = finalUrl.previousKhutbh + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            self.previousKhutbah = PreviousKhutbahBaseClass(json: json)
            self.tblKhutbahs.reloadData()
            SVProgressHUD.dismiss()
          
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }

    func getEidKhutbahs(yearID : String){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID,"year_id" : yearID,"user_token_id" : appDelegate.identifierForAdvertising()!]
        print(parameter)
        let iMaamListUrl = finalUrl.previousFridayAudio + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
             if json["data"].count != 0 {
            let player = self.storyboard?.instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
            player.catID = self.catID
            player.subCatID = self.subCatID
            player.json = json
            player.yearID = yearID
            self.navigationController?.pushViewController(player, animated: true)
             }else {
                showAlert()
            }
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
}
extension KhutbahsYearsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if previousKhutbah?.data != nil {
            return previousKhutbah!.data!.count
        }else {
            return 0
        }
     }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleCell", for: indexPath) as! SingleCell
      cell.lblName.text = previousKhutbah!.data![indexPath.row].yearName!
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblKhutbahs.deselectRow(at: indexPath, animated: true)
        if subCatID == "2" || subCatID == "11" {
            let MonthList = self.storyboard?.instantiateViewController(withIdentifier: "MonthListVC") as! MonthListVC
            MonthList.catID = catID
            MonthList.subCatID = subCatID
            MonthList.yearID = previousKhutbah!.data![indexPath.row].yearId!
            self.navigationController?.pushViewController(MonthList, animated: true)
        }else {  // 5,14
            getEidKhutbahs(yearID: previousKhutbah!.data![indexPath.row].yearId!)
           
        }
   
        
    }
    
}
