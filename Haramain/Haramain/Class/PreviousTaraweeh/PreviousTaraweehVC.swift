//
//  PreviousTaraweehVC.swift
//  Haramain
//
//  Created by naman on 05/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
class PreviousTaraweehVC: UIViewController {

    var catID:String = ""
    var subCatID = ""
    var tareweeh : TareweehBaseClass?
    @IBOutlet weak var tblTawa: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "SingleCell", bundle: nil)
        tblTawa.register(nib, forCellReuseIdentifier: "SingleCell")
        self.getTareWeehList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getTareWeehList(){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID]
        print(parameter)
        let iMaamListUrl = finalUrl.Taraweeh + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
            self.tareweeh = TareweehBaseClass(json: json)
            self.tblTawa.reloadData()
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }

    func getTareWeehPlayer(yearID : String){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID , "year_id" : yearID,"user_token_id" : appDelegate.identifierForAdvertising()!]
        print(parameter)
        let iMaamListUrl = finalUrl.TaraweehAudio + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            if json["data"].count != 0 {
                let playImmam = self.storyboard?.instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
                playImmam.catID = self.catID
                playImmam.subCatID = self.subCatID
                playImmam.immamID = yearID
                playImmam.json = json
                self.navigationController?.pushViewController(playImmam, animated: true)
            }else {
                showAlert()
            }
            SVProgressHUD.dismiss()
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
}
extension PreviousTaraweehVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.tareweeh?.data?.count != nil {
            return self.tareweeh!.data!.count
        }else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleCell", for: indexPath) as! SingleCell
       cell.lblName.text = tareweeh!.data![indexPath.row].yearName
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        getTareWeehPlayer(yearID: tareweeh!.data![indexPath.row].yearId!)
        self.tblTawa.deselectRow(at: indexPath, animated: true)
       
        
    }
    
}
