//
//  GalleryViewListVC.swift
//  Haramain
//
//  Created by naman on 12/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class GalleryViewListVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblGallery: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CellWithButtonCell", bundle: nil)
        tblGallery.register(nib, forCellReuseIdentifier: "CellWithButtonCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GalleryViewListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 0
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithButtonCell", for: indexPath) as! CellWithButtonCell
     
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblGallery.deselectRow(at: indexPath, animated: true)
        
    }
}
