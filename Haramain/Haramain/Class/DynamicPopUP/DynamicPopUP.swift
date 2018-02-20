//
//  DynamicPopUP.swift
//  Haramain
//
//  Created by naman on 20/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class DynamicPopUP: UIViewController {

    @IBOutlet var tblView: UITableView!
    var dataType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nib = UINib(nibName: "CellWithButtonCell", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "CellWithButtonCell")
        self.tblView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension DynamicPopUP: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return (appDelegate.mosqueMainModel?.data!.galleryKey?.last!.subCategory!.count)!
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithButtonCell", for: indexPath) as! CellWithButtonCell
        cell.lblName.text = appDelegate.mosqueMainModel?.data!.galleryKey?.last!.subCategory![indexPath.row].galleryCategoryName
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
}

