//
//  LanguageListVC.swift
//  Haramain
//
//  Created by naman on 07/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD

class LanguageListVC: UIViewController {

    @IBOutlet weak var tblLanguageList: UITableView!
    var catID = ""
    var subCatID = ""
    var yearID = ""
    var monthName = ""
    var languageList : LanguageListBaseClass?
    var arrNawabImg = [#imageLiteral(resourceName: "arabic"),#imageLiteral(resourceName: "english"),#imageLiteral(resourceName: "french"),#imageLiteral(resourceName: "hausa"),#imageLiteral(resourceName: "indonesiya"),#imageLiteral(resourceName: "turkish"),#imageLiteral(resourceName: "uradu")]
    var arrHaramImg = [#imageLiteral(resourceName: "arabic"),#imageLiteral(resourceName: "english")]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLanguageList()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
   
    func getLanguageList(){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID]
        print(parameter)
        let iMaamListUrl = finalUrl.previousLanguage + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            self.languageList = LanguageListBaseClass(json: json)
            self.tblLanguageList.reloadData()
            SVProgressHUD.dismiss()
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
 
    func getFridayKhutbahs(languageID : String){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID , "language_id" : languageID , "year_id" : yearID , "month" : monthName,"user_token_id" : appDelegate.identifierForAdvertising()!]
        print(parameter)
        let fridayAudioFinalURL = finalUrl.previousFridayAudio + parameter.queryString()
        print(fridayAudioFinalURL)
        let escapedString = fridayAudioFinalURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        getDataFromUrl(url: escapedString!, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
             if json["data"].count != 0 {
            let playImmam = self.storyboard?.instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
            playImmam.catID = self.catID
            playImmam.subCatID = self.subCatID
            playImmam.immamID = ""
            playImmam.yearID = self.yearID
            playImmam.json = json
            playImmam.monthName = self.monthName
            playImmam.languageID = languageID
            self.navigationController?.pushViewController(playImmam, animated: true)
             }else{
                showAlert()
            }
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    

}
extension LanguageListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if languageList?.data == nil {
            return 0
        }else {
            return languageList!.data!.count
        }
     }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        cell.lblLanguageTitle.text = self.languageList!.data![indexPath.row].languageName!
        cell.ivLanguage.image = subCatID == "2" ? arrHaramImg[indexPath.row] : arrNawabImg[indexPath.row]
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tblLanguageList.deselectRow(at: indexPath, animated: true)
        self.getFridayKhutbahs(languageID: yearID)
 }
    
}
