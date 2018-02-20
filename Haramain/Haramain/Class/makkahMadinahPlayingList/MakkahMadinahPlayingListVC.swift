//
//  MadeenahDailySalaahVC.swift
//  Haramain
//
//  Created by naman on 15/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import AVFoundation
import MediaPlayer

class MakkahMadinahPlayingListVC: UIViewController {

    //ViewPlayer
    @IBOutlet var viewPlayer: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubTitle: UILabel!
    @IBOutlet var lblEndText: UILabel!
    @IBOutlet var lblStartText: UILabel!
    @IBOutlet var sliderPlayer: UISlider!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnPrevious: UIButton!
    @IBOutlet var btnPlay: UIButton!
    
    // Table Bottom Constrain
    @IBOutlet var tblBottomConstrain: NSLayoutConstraint!
    
    
    var makkahPlayer : MakkahPlayerListBaseClass?
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var tblMakkahPlayingList: UITableView!
    var subCatID = ""
    var catID = ""
    var currentIndexPathRow = -1
    var currentIndexPathSection = -1
    var playerArray = Array<JSON>()
    var isNewDataLoading : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMakkahDailyPlayList(maxID:"")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Helper Methods
    func nextFunc() {
        if self.makkahPlayer!.entries![currentIndexPathSection].urls!.count == 1{
            currentIndexPathSection = currentIndexPathSection + 1
            currentIndexPathRow = 0
        }else if currentIndexPathRow == self.makkahPlayer!.entries![currentIndexPathSection].urls!.count - 1 {
            currentIndexPathSection = currentIndexPathSection + 1
            currentIndexPathRow = 0
        }else {
        
            currentIndexPathRow = currentIndexPathRow + 1
        }
        
          self.callConfigurablePlayer()
    }
    func preFunc() {
        if self.makkahPlayer!.entries![currentIndexPathSection].urls!.count == 1{
            currentIndexPathSection = currentIndexPathSection - 1
            currentIndexPathRow = 0
        }else if currentIndexPathRow == self.makkahPlayer!.entries![currentIndexPathSection].urls!.count - 1 {
            currentIndexPathSection = currentIndexPathSection - 1
            currentIndexPathRow = 0
        }else {
            
            currentIndexPathRow = currentIndexPathRow - 1
        }
        
        self.callConfigurablePlayer()
    }
    func callCategoryWise() {
        
        self.lblTitle.text = String(describing: self.makkahPlayer!.entries![currentIndexPathSection].urls![currentIndexPathRow].type) + "-" + String(describing: self.makkahPlayer!.entries![currentIndexPathSection].urls![currentIndexPathRow].sheikh)
        
    }
    func callConfigurablePlayer(){
        SVProgressHUD.show()
        self.configureView(urlString: self.makkahPlayer!.entries![currentIndexPathSection].urls![currentIndexPathRow].url!)
        self.btnPlay.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        
    }
    func configureView(urlString : String) {
        if currentIndexPathSection == 0 {
            btnPrevious.isHidden = true
            btnNext.isHidden = false
            
        }else if currentIndexPathSection == self.makkahPlayer!.entries!.count {
            btnNext.isHidden = true
            btnPrevious.isHidden = false
            
        }else {
            btnPrevious.isHidden = false
            btnNext.isHidden = false
        }
        
         self.lblTitle.text = String(describing:self.makkahPlayer!.entries![currentIndexPathSection].urls![currentIndexPathRow].type!) + String(describing:self.makkahPlayer!.entries![currentIndexPathSection].urls![currentIndexPathRow].sheikh!)
        
        appDelegate.playerItem = AVPlayerItem(asset: AVURLAsset(url: URL(string: urlString)!))
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: appDelegate.playerItem)
        
        appDelegate.player = AVPlayer(playerItem: appDelegate.playerItem)
        appDelegate.player.play()
        self.btnPlay.setImage(#imageLiteral(resourceName: "play_icon"), for: .normal)
        self.startPlayeing()
    }
    
    @objc func playerItemDidPlayToEndTime() {
        // load next video or something
        if currentIndexPathSection == self.makkahPlayer!.entries!.count {
            appDelegate.player.pause()
            self.btnPlay.setImage(#imageLiteral(resourceName: "play_song"), for: .normal)
        }else {
            currentIndexPathSection = currentIndexPathSection + 1
            self.callConfigurablePlayer()
        }
    }
    func startPlayeing() {
        self.setupNowPlaying()
        self.setupRemoteTransportControls()
        appDelegate.player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if appDelegate.player.currentItem!.status == .readyToPlay {
                SVProgressHUD.dismiss()
                let totalTime = appDelegate.player.currentItem!.duration.seconds
                
                self.lblEndText.text = String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(totalTime)).0) + " : " + String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(totalTime)).1) + " : " + String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(totalTime)).2)
                
                self.sliderPlayer.maximumValue = Float(totalTime)
                let time : Float64 = CMTimeGetSeconds(appDelegate.player.currentTime());
                self.sliderPlayer.value = Float (time);
                self.lblStartText.text = String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(time)).0) + " : " + String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(time)).1) + " : " + String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(time)).2)
                
            }
        }
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //Bottom Refresh
        
        if scrollView == tblMakkahPlayingList{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if !isNewDataLoading{
                    isNewDataLoading = true
                    if self.makkahPlayer!.entries!.count != 0 {
                        self.getMakkahDailyPlayList(maxID:String(describing:self.makkahPlayer!.entries!.last!.id!))
                    }
                    
                    
                }
            }
        }
    }
     // MARK: - Api
    func getMakkahDailyPlayList(maxID : String){
        SVProgressHUD.show()
        let parameter = ["maxId" : maxID]
        
        getDataFromUrl(url: finalUrl.haramainDaily + subCatID + "?" + parameter.queryString(), headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
            print(json)
            SVProgressHUD.dismiss()
            self.makkahPlayer = MakkahPlayerListBaseClass(json: json)
            print(self.makkahPlayer!.entries!.count)
            print(self.makkahPlayer!.entries![0].urls!.count)
            
            self.tblMakkahPlayingList.reloadData()
           
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    // MARK: - Selector
    @IBAction func btnPlayClicked(_ sender: Any) {
        if self.btnPlay.currentImage! == #imageLiteral(resourceName: "play_song") {
            appDelegate.player.play()
            self.btnPlay.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        }else {
            appDelegate.player.pause()
            self.btnPlay.setImage(#imageLiteral(resourceName: "play_song"), for: .normal)
        }
    }
    @IBAction func btnNextClicked(_ sender: Any) {
        nextFunc()
    }
    
    @IBAction func btnPreviousClicked(_ sender: Any) {
        preFunc()
    }
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sliderPlayer(_ sender: Any) {
        let seconds : Int64 = Int64(sliderPlayer.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        appDelegate.player.seek(to: targetTime)
        
        if appDelegate.player.rate == 0
        {
            appDelegate.player.play()
        }
    }
    
    
    //MARK:- Lockscreen Media Control
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { event in
            if appDelegate.player.rate == 0.0 {
                appDelegate.player.play()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { event in
            if appDelegate.player.rate == 1.0 {
                appDelegate.player.pause()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            if appDelegate.player.rate == 1.0 {
                self.nextFunc()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            if appDelegate.player.rate == 1.0 {
                self.preFunc()
                return .success
            }
            return .commandFailed
        }
    }
    
    func setupNowPlaying() {
        // Define Now Playing Info
        let artistName = String(describing:self.makkahPlayer!.entries![currentIndexPathSection].urls![currentIndexPathRow].type) + "-" +  String(describing:self.makkahPlayer!.entries![currentIndexPathSection].urls![currentIndexPathRow].text)
        
        
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyArtist] = artistName
       // nowPlayingInfo[MPMediaItemPropertyTitle] = songName
        
        if let image = UIImage(named: "AppIcon") {
            if #available(iOS 10.0, *) {
                nowPlayingInfo[MPMediaItemPropertyArtwork] =
                    MPMediaItemArtwork(boundsSize: image.size) { size in
                        return image
                }
            } else {
                // Fallback on earlier versions
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = appDelegate.playerItem.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = appDelegate.playerItem.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = appDelegate.player.rate
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        
    }
}
extension MakkahMadinahPlayingListVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.makkahPlayer?.entries?.count == nil {
             return 0
        }else {
             return self.makkahPlayer!.entries!.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.makkahPlayer!.entries![section].urls!.count == 1 {
            return 1
        }else {
            return self.makkahPlayer!.entries![section].urls!.count + 1
            
        }
       
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MakkahMultipleLineTableViewCell", for: indexPath) as! MakkahMultipleLineTableViewCell
            cell.lblSuraText.text = self.makkahPlayer!.entries![indexPath.section].suraText!
            cell.lblTitle.text = self.makkahPlayer!.entries![indexPath.section].title!
            cell.lblSingerName.text = self.makkahPlayer!.entries![indexPath.section].urls![0].sheikh!
            
             return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MakkahMadinahPlayerSingleTableViewCell", for: indexPath) as! MakkahMadinahPlayerSingleTableViewCell
            cell.lblTitle.text = String(describing:self.makkahPlayer!.entries![indexPath.section].urls![indexPath.row - 1].type!) + String(describing:self.makkahPlayer!.entries![indexPath.section].urls![indexPath.row - 1].sheikh!)
           return cell
        }
 }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tblBottomConstrain.constant = 120
        
      
        if indexPath.row == 0 {
            currentIndexPathRow = indexPath.row
            currentIndexPathSection = indexPath.section
            self.configureView(urlString: self.makkahPlayer!.entries![indexPath.section].urls![0].url!)
           
        }else {
            currentIndexPathRow = indexPath.row - 1
            currentIndexPathSection = indexPath.section

            self.configureView(urlString: self.makkahPlayer!.entries![indexPath.section].urls![indexPath.row - 1].url!)
        }
    }
    
}
