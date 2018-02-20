//
//  GpsHeadingVC.swift
//  Haramain
//
//  Created by naman on 12/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
class GpsHeadingVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblGpsHeadiing: UITableView!
    @IBOutlet weak var lblYear: UILabel!
    var catID = ""
    var titleText = ""
    var gpsModel : GpsHeadingBaseClass?
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GpsLightCell", bundle: nil)
        tblGpsHeadiing.register(nib, forCellReuseIdentifier: "GpsLightCell")
        self.getGpsHeading()
        self.lblYear.text = titleText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getGpsHeading(){
        SVProgressHUD.show()
        let parameter = ["category_id" : catID]
        print(parameter)
        let gpsFinalUrl = finalUrl.gpsHeadings + parameter.queryString()

        getDataFromUrl(url: gpsFinalUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            self.gpsModel = GpsHeadingBaseClass(json: json)
            SVProgressHUD.dismiss()
            self.tblGpsHeadiing.reloadData()
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }

}
extension GpsHeadingVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.gpsModel?.data?.count != nil {
            return self.gpsModel!.data!.count
        }else {
            return 0
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GpsLightCell", for: indexPath) as! GpsLightCell
        cell.lblGpsLight.text = gpsModel!.data![indexPath.row].gpsHeading
        cell.lblGpsLight.textColor = UIColor.black
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblGpsHeadiing.deselectRow(at: indexPath, animated: true)
        let gpsSubHeading = self.storyboard?.instantiateViewController(withIdentifier: "GpsSubHeadingVC") as! GpsSubHeadingVC
        gpsSubHeading.catID = self.gpsModel!.data![indexPath.row].gpsHeadingId!
        gpsSubHeading.titleText = self.gpsModel!.data![indexPath.row].gpsHeading!
        self.navigationController?.pushViewController(gpsSubHeading, animated: true)
      
    }
}
