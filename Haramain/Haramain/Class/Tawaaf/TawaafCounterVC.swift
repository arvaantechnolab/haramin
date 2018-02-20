//
//  TawaafCounterVC.swift
//  Haramain
//
//  Created by Arvaan on 01/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class TawaafCounterVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnReset: UIButton!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var counterTableView: UITableView!
    @IBOutlet var lblCircumambulationTime: UILabel!
    @IBOutlet var lblPageCounter: UILabel!
    @IBOutlet var lblTotalTime: UILabel!
    
    var timer = Timer()
    var seconds = 00
    var totalseconds = 00
    var isTimerRunning = false
    
    var arrSave : [TawaafCounterModel] = []
    var arrCount = ["First","Second","Third","Fourth","Fifth","Six","Seven"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.layer.cornerRadius = 3
        btnNext.layer.masksToBounds = true
        
        btnReset.layer.cornerRadius = 3
        btnReset.layer.masksToBounds = true
        
        runTimer()
        runTotalTimer()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSave.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TawaafCounterCell") as! TawaafCounterCell
        print(arrSave[indexPath.row].name!)
        cell.lblName.text = arrSave[indexPath.row].name
        cell.lblTime.text = arrSave[indexPath.row].time
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnNext(_ sender: UIButton) {
        
        
        if arrSave.count != 0 {
            lblPageCounter.text = String(arrSave.count + 2)
            if arrSave.count <= 4{
                let obj = TawaafCounterModel(id: arrCount[arrSave.count], Name: lblCircumambulationTime.text!)
                arrSave.append(obj)
                counterTableView.reloadData()
                
            }
            else if arrSave.count == 5{
                let obj = TawaafCounterModel(id: arrCount[arrSave.count], Name: lblCircumambulationTime.text!)
                arrSave.append(obj)
                counterTableView.reloadData()
                btnNext.setTitle("Finish", for: .normal)
            }
            else if arrSave.count == 6 {
                let obj = TawaafCounterModel(id: arrCount[arrSave.count], Name: lblCircumambulationTime.text!)
                arrSave.append(obj)
                counterTableView.reloadData()
                btnNext.isHidden = true
                lblPageCounter.text = "0"
            }
           
            
        }else{
            lblPageCounter.text = "2"
            let obj = TawaafCounterModel(id: arrCount[0], Name: lblCircumambulationTime.text!)
            arrSave.append(obj)
        counterTableView.reloadData()
        }
        
        seconds = 00
        let stop = timeString(time: TimeInterval(seconds))
        lblCircumambulationTime.text = stop
        
        
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        arrSave.removeAll()
        btnNext.isHidden   = false
        btnNext.setTitle("Next", for: .normal)
        counterTableView.reloadData()
        lblPageCounter.text = "1"
        seconds = 00
        totalseconds = 00
        let stop = timeString(time: TimeInterval(seconds))
        lblCircumambulationTime.text = stop
        lblTotalTime.text = stop
        runTimer()
        runTotalTimer()
        isTimerRunning = false
    }
    

    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    func totaltimeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let totalseconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, totalseconds)
    }
    @objc func updateTimer(){
            seconds += 1
            let start = timeString(time: TimeInterval(seconds))
            lblCircumambulationTime.text = start
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)),
                                     userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    func runTotalTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTotalTimer)),
                                     userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateTotalTimer(){
        totalseconds += 1
        let start = totaltimeString(time: TimeInterval(totalseconds))
        lblTotalTime.text = start
    }

}
