//
//  MuadhinsVC.swift
//  Haramain
//
//  Created by naman on 11/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class MuadhinsVC: UIViewController {

    @IBOutlet weak var tblMudhins: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    var catID = ""
    var subID = ""
    
    //var arrMudhins = ["Adhaan","Eid Takbeerat","Interviews","Janazah Salaah","Tableegh Styles","Talbiyah"]
   // var arrMudhinsArabic = ["أذان","تكبيرات العيد","المقابلات","صلاة الجنازة","مقامات تبيليغ","التلبية"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nib = UINib(nibName: "CellWithButtonCell", bundle: nil)
        tblMudhins.register(nib, forCellReuseIdentifier: "CellWithButtonCell")
        
        self.tblMudhins.reloadData()
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
extension MuadhinsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if catID == "1" {
            return 6
        }else {
            return 5
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
       cell.lblName.textColor = UIColor.black
        if indexPath.row == 0 {
            cell.lblName.text = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![3].subCategoryName! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![3].subCategoryName!
            cell.accessibilityValue = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![3].subCategoryId! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![3].subCategoryId!
        }else if indexPath.row == 1 {
            cell.lblName.text = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![5].subCategoryName! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![5].subCategoryName!
            cell.accessibilityValue = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![5].subCategoryId! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![5].subCategoryId!
        }else if indexPath.row == 2 {
            cell.lblName.text = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![11].subCategoryName! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![9].subCategoryName!
            cell.accessibilityValue = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![11].subCategoryId! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![9].subCategoryId!
        }else if indexPath.row == 3 {
            cell.lblName.text = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![9].subCategoryName! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![10].subCategoryName!
            cell.accessibilityValue = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![9].subCategoryId! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![10].subCategoryId!
        }else if indexPath.row == 4 {
            cell.lblName.text = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![10].subCategoryName! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![11].subCategoryName!
            cell.accessibilityValue = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![10].subCategoryId! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![11].subCategoryId!
        }else if indexPath.row == 5 {
            cell.lblName.text = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![12].subCategoryName! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![11].subCategoryName!
            cell.accessibilityValue = catID == "1" ? appDelegate.mosqueMainModel!.data!.masjidAlHaram!.subCategoryDetail![12].subCategoryId! : appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.subCategoryDetail![11].subCategoryId!
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tblMudhins.deselectRow(at: indexPath, animated: true)
       
        
        let currentCell = tableView.cellForRow(at: indexPath)
        print(currentCell!.accessibilityValue!)
        let singer = self.storyboard?.instantiateViewController(withIdentifier: "SingerListVC") as! SingerListVC
        singer.catID = catID
        singer.subCatID = currentCell!.accessibilityValue!
        self.navigationController?.pushViewController(singer, animated: true)
       
    }
    
}
