//
//  SingerListVC.swift
//  Haramain
//
//  Created by naman on 07/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class MonthListVC: UIViewController {

    @IBOutlet weak var tblSingerList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    var catID = ""
    var subCatID = ""
    var yearID = ""
    var singerListEnglish = ["Muharram","Safar","Rabiul Awwal","Rabiul Akhir","Jumadal Awwal","Jumadal Akhir","Rajab","Shabaan","Ramadhan","Shawaal","Dhul Qadah","Dhul Hijjah"]
    var singerListArabic = ["مُحَرَّم","صَفَر","رَبيع الأوّل","رَبيع الثاني","جُمادى الأولى","جُمادى الآخرة","رَجَب"," شَعْبان","رَمَضان","شَوّال","ذو القعدة","ذو الحجة"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "SingleCell", bundle: nil)
        tblSingerList.register(nib, forCellReuseIdentifier: "SingleCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
extension MonthListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if languageDefault == 0 {
            return singerListEnglish.count
        }else {
            return singerListArabic.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleCell", for: indexPath) as! SingleCell
        cell.lblName.text = languageDefault == 0 ? singerListEnglish[indexPath.row] : singerListArabic[indexPath.row]
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tblSingerList.deselectRow(at: indexPath, animated: true)
        let languageList = self.storyboard?.instantiateViewController(withIdentifier: "LanguageListVC") as! LanguageListVC
        languageList.catID = catID
        languageList.subCatID = subCatID
        languageList.yearID = yearID
        languageList.monthName = languageDefault == 0 ? singerListEnglish[indexPath.row] : singerListArabic[indexPath.row]
        self.navigationController?.pushViewController(languageList, animated: true)
        
    }
    
}
