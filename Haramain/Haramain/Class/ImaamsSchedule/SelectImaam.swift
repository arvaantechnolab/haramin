//
//  SelectImaam.swift
//  Haramain
//
//  Created by naman on 04/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
class SelectImaam: UIViewController {

    var catID:String = ""
    var subCatID = ""
    var immamModel : ImmamBaseClass?
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblImmam: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "MultiLineCell", bundle: nil)
        tblImmam.register(nib, forCellReuseIdentifier: "MultiLineCell")
        self.immamModel = ImmamBaseClass(json:[])
        getImmamList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getImmamList(){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID]
        print(parameter)
        let iMaamListUrl = finalUrl.ImmamList + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
            self.immamModel = ImmamBaseClass(json: json)
            self.tblImmam.reloadData()
            
           
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    func getImmamPlayer(immamID : String){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID , "imaam_id" : immamID ,"user_token_id" : appDelegate.identifierForAdvertising()!]
        print(parameter)
        let iMaamListUrl = finalUrl.ImmamAudio + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
            if json["data"].count != 0 {
            let playImmam = self.storyboard?.instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
            playImmam.catID = self.catID
            playImmam.subCatID = self.subCatID
            playImmam.json = json
            playImmam.immamID = immamID
            self.navigationController?.pushViewController(playImmam, animated: true)
            }else {
                showAlert()
            }
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
}

extension SelectImaam: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if self.immamModel?.data?.count != nil {
            return self.immamModel!.data!.count
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MultiLineCell", for: indexPath) as! MultiLineCell
        cell.lblTop.text = immamModel!.data![indexPath.row].imaamName!
        cell.lblBottom.text = immamModel!.data![indexPath.row].imaamDescription!
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.getImmamPlayer(immamID: immamModel!.data![indexPath.row].imaamId!)
        self.tblImmam.deselectRow(at: indexPath, animated: true)
     
        
    }
    
}
