//
//  GpsSubHeadingVC.swift
//  Haramain
//
//  Created by naman on 12/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
class GpsSubHeadingVC: UIViewController {

    @IBOutlet weak var tblGpsSubHeading: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblSubHeading: UILabel!
    var gpsSubHeading : GpsSubHeadingBaseClass?
    var catID = ""
    var titleText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GpsLightCell", bundle: nil)
        tblGpsSubHeading.register(nib, forCellReuseIdentifier: "GpsLightCell")
        self.getSubGpsHeading()
       self.lblSubHeading.text = self.titleText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
          _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getSubGpsHeading(){
        SVProgressHUD.show()
        let parameter = ["gps_heading_id" : catID ]
        print(parameter)
        let gpsFinalUrl = finalUrl.gpsSubHeadings + parameter.queryString()
        getDataFromUrl(url: gpsFinalUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
            self.gpsSubHeading = GpsSubHeadingBaseClass(json: json)
            
             self.tblGpsSubHeading.reloadData()
           
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
}
extension GpsSubHeadingVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.gpsSubHeading?.data?.count == nil {
            return 0
        }else {
            return self.gpsSubHeading!.data!.count
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GpsLightCell", for: indexPath) as! GpsLightCell
        cell.lblGpsLight.text = self.gpsSubHeading!.data![indexPath.row].gpsPlace
        cell.lblGpsLight.textColor = UIColor.black
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblGpsSubHeading.deselectRow(at: indexPath, animated: true)
        
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)
        {
            let urlString = "http://maps.google.com/?daddr=\(self.gpsSubHeading!.data![indexPath.row].latitude!),\(self.gpsSubHeading!.data![indexPath.row].longitude!)&directionsmode=driving"
             UIApplication.shared.openURL(URL(string: urlString)!)
        }
        else
        {
            
            let urlString = "http://maps.apple.com/maps?daddr=\(self.gpsSubHeading!.data![indexPath.row].latitude!),\(self.gpsSubHeading!.data![indexPath.row].longitude!)&dirflg=d"
            
            UIApplication.shared.openURL(URL(string: urlString)!)
        }
      
}
}
