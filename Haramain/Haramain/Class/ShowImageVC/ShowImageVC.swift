//
//  ShowImageVC.swift
//  Haramain
//
//  Created by naman on 06/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import ImageViewer
class ShowImageVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblShowImage: UITableView!
    var subCatId = ""
    var catID = ""
    var imageModel : ImageBaseClass?
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "OnlyImageCell", bundle: nil)
        tblShowImage.register(nib, forCellReuseIdentifier: "OnlyImageCell")
        if subCatId != "" {
            getImages()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImages(){
        SVProgressHUD.show()
        let parameter = ["gallery_category_id" : subCatId]
        print(parameter)
        let iMaamListUrl = finalUrl.GalleryImages + parameter.queryString()
        getDataFromUrl(url: iMaamListUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
            self.imageModel = ImageBaseClass(json: json)
            self.tblShowImage.reloadData()
       
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
extension ShowImageVC: UITableViewDataSource, UITableViewDelegate{
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subCatId == "" && catID == "1"{
            return appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage!.count
        }else  if subCatId == "" && catID == "2"{
            return appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage!.count
        }else if self.imageModel == nil {
            return 0
        }else {
            return self.imageModel!.data!.count
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyImageCell", for: indexPath) as! OnlyImageCell
        
        if subCatId == "" && catID == "1"{
            cell.ivImageCell.sd_setImage(with:URL(string:appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage![indexPath.row]), completed: nil)
        }else  if subCatId == "" && catID == "2"{
            cell.ivImageCell.sd_setImage(with:URL(string:appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage![indexPath.row]), completed: nil)
          
        }else {
            cell.ivImageCell.sd_setImage(with: URL(string:self.imageModel!.data![indexPath.row].imageUrl!), completed: nil)
        }
        
        
       return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
