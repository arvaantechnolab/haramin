//
//  KhutbahsVC.swift
//  Haramain
//
//  Created by naman on 07/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class KhutbahsVC: UIViewController {

    @IBOutlet weak var tblKhutbahs: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    var arrEnglish = ["Previous Friday Khutbahs With Translation","Eid Khutbans"]
    var arrArabic = ["",""]
    var catID = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CellWithButtonCell", bundle: nil)
        tblKhutbahs.register(nib, forCellReuseIdentifier: "CellWithButtonCell")
       
        self.tblKhutbahs.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBackClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    

}
extension KhutbahsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return languageDefault == 0 ? arrEnglish.count : arrArabic.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithButtonCell", for: indexPath) as! CellWithButtonCell
        cell.lblName.text = languageDefault == 0 ? arrEnglish[indexPath.row] : arrArabic[indexPath.row]
        cell.lblName.textColor = UIColor.black
        cell.viewButton.backgroundColor = UIColor.lightGray
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblKhutbahs.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 && catID == "1" {
            let immam = self.storyboard?.instantiateViewController(withIdentifier:"KhutbahsYearsVC") as! KhutbahsYearsVC
            immam.catID = catID
            immam.subCatID = "2"
            self.navigationController?.pushViewController(immam, animated: true)
        }else if indexPath.row == 0 && catID == "2" {
            let immam = self.storyboard?.instantiateViewController(withIdentifier:"KhutbahsYearsVC") as! KhutbahsYearsVC
            immam.catID = catID
            immam.subCatID = "11"
            self.navigationController?.pushViewController(immam, animated: true)
        }else if indexPath.row == 1 && catID == "1" {
            let immam = self.storyboard?.instantiateViewController(withIdentifier:"KhutbahsYearsVC") as! KhutbahsYearsVC
            immam.catID = catID
            immam.subCatID = "5"
            self.navigationController?.pushViewController(immam, animated: true)
        }else if indexPath.row == 1 && catID == "2" {
            let immam = self.storyboard?.instantiateViewController(withIdentifier:"KhutbahsYearsVC") as! KhutbahsYearsVC
            immam.catID = catID
            immam.subCatID = "14"
            self.navigationController?.pushViewController(immam, animated: true)
        }
    }
}
