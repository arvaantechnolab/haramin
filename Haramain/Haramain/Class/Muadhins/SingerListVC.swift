//
//  SingerListVC.swift
//  Haramain
//
//  Created by naman on 11/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD

class SingerListVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblSingerList: UITableView!
    var catID = ""
    var subCatID = ""
    var singerList : SingerListBaseClass?
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "SingleCell", bundle: nil)
        tblSingerList.register(nib, forCellReuseIdentifier: "SingleCell")
        
        self.getSingerList()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSingerList(){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID]
        print(parameter)
        let iMaamListUrl = finalUrl.MuadhinsList + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            self.singerList = SingerListBaseClass(json: json)
            self.tblSingerList.reloadData()
            SVProgressHUD.dismiss()
           
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    func getSingerSongs(subCatId : String){
        SVProgressHUD.show()
        let parameter = ["sub_category_id" : subCatID,"m_id" :subCatId]
        print(parameter)
        let iMaamListUrl = finalUrl.MuadhinAudioList + parameter.queryString()
        
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            if json["data"].count != 0 {
                let playerVC = self.storyboard?.instantiateViewController(withIdentifier:"PlayerVC") as! PlayerVC
                playerVC.catID = self.catID
                playerVC.subCatID = self.subCatID
                playerVC.json = json
                playerVC.mID = subCatId
                
                self.navigationController?.pushViewController(playerVC, animated: true)
            }
           
            SVProgressHUD.dismiss()
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
}

extension SingerListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.singerList?.data?.count != nil {
            return self.singerList!.data!.count
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleCell", for: indexPath) as! SingleCell
        cell.lblName.text = self.singerList!.data![indexPath.row].muadhinName!
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.getSingerSongs(subCatId:self.singerList!.data![indexPath.row].mId! )
        
     
        
        
    }
}
