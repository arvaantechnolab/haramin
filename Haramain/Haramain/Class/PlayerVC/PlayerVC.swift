//
//  PlayerVC.swift
//  Haramain
//
//  Created by naman on 05/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import AVFoundation
import MediaPlayer
class PlayerVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPlayingSong: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tblPlayer: UITableView!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var sliderPlayer: UISlider!
    
    var catID = ""
    var subCatID = ""
    var immamID = ""
    var languageID = ""
    var yearID = ""
    var monthName = ""
    var mID = ""
    var immamPlay : ImmamAudioBaseClass?
    var json = JSON()
    
    var currentPlayingIndex = 0
    // MARK: - ViewDidLoad Methods
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PlayerCell", bundle: nil)
        tblPlayer.register(nib, forCellReuseIdentifier: "PlayerCell")
        callCategoryWise()
        let view = UIView()
        view.backgroundColor = UIColor.clear
        self.tblPlayer.tableFooterView = view
       
        //UIApplication.shared.beginReceivingRemoteControlEvents()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func deallocObservers(player: AVPlayer) {
        player.removeObserver(self, forKeyPath: "status")
    }
    // MARK: - Api Call Methods
    func callCategoryWise() {
        
        self.immamPlay = ImmamAudioBaseClass(json: json)
        self.lblTitle.text = self.immamPlay!.data![currentPlayingIndex].audioTitle!
        self.lblPlayingSong.text = "Playing :" + self.immamPlay!.data![currentPlayingIndex].audioArtist!
      
    }
   
    // MARK: - Button Clickable
    @IBAction func btnnextClicked(_ sender: Any) {
        nextFunc()
    }
    @IBAction func btnPreviousClicked(_ sender: Any) {
       preFunc()
    }
    @IBAction func btnPlayClicked(_ sender: Any) {
        if self.btnPlay.currentImage! == #imageLiteral(resourceName: "play_song") {
            appDelegate.player.play()
            self.btnPlay.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        }else {
            appDelegate.player.pause()
            self.btnPlay.setImage(#imageLiteral(resourceName: "play_song"), for: .normal)
            
        }
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
          _ = self.navigationController?.popViewController(animated: true)
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
    // MARK: - Helper Methods
    func nextFunc() {
        if currentPlayingIndex == self.immamPlay!.data!.count - 1{
            currentPlayingIndex = 0
            callConfigurablePlayer()
        }else {
            currentPlayingIndex = currentPlayingIndex + 1
            self.callConfigurablePlayer()
        }
    }
    func preFunc() {
        if currentPlayingIndex == 0 {
            currentPlayingIndex = 0
            callConfigurablePlayer()
        }else {
            currentPlayingIndex = currentPlayingIndex - 1
            self.callConfigurablePlayer()
        }
    }
    
    func callConfigurablePlayer(){
        SVProgressHUD.show()
        if self.immamPlay?.data?[currentPlayingIndex].audioName == nil {
            self.configureView(urlString:self.immamPlay!.data![currentPlayingIndex].audioUrl!)
        }else {
            self.configureView(urlString:self.immamPlay!.data![currentPlayingIndex].audioName!)
        }
        self.btnPlay.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        
    }
    func configureView(urlString : String) {
        if currentPlayingIndex == 0 {
            btnPrevious.isHidden = true
            btnNext.isHidden = false

        }else if currentPlayingIndex == self.immamPlay!.data!.count - 1{
            btnNext.isHidden = true
            btnPrevious.isHidden = false

        }else {
            btnPrevious.isHidden = false
            btnNext.isHidden = false
        }
       
        
        // Set title
        self.lblTitle.text = self.immamPlay!.data![currentPlayingIndex].audioTitle!
        self.lblPlayingSong.text = "Playing :" + self.immamPlay!.data![currentPlayingIndex].audioArtist!
        
        // Play song
        appDelegate.playerItem = AVPlayerItem(asset: AVURLAsset(url: URL(string: urlString)!))
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: appDelegate.playerItem)
    
        appDelegate.player = AVPlayer(playerItem: appDelegate.playerItem)
        appDelegate.player.play()
        self.btnPlay.setImage(#imageLiteral(resourceName: "play_icon"), for: .normal)
        self.startPlayeing()
    }
    @objc func playerItemDidPlayToEndTime() {
        // load next video or something
        if currentPlayingIndex == self.immamPlay!.data!.count - 1 {
            appDelegate.player.pause()
            self.btnPlay.setImage(#imageLiteral(resourceName: "play_song"), for: .normal)
        }else {
            currentPlayingIndex = currentPlayingIndex + 1
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
                
                self.lblEndTime.text = String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(totalTime)).0) + " : " + String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(totalTime)).1) + " : " + String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(totalTime)).2)
               
                self.sliderPlayer.maximumValue = Float(totalTime)
                let time : Float64 = CMTimeGetSeconds(appDelegate.player.currentTime());
                self.sliderPlayer.value = Float (time);
                self.lblStartTime.text = String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(time)).0) + " : " + String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(time)).1) + " : " + String(describing: self.secondsToHoursMinutesSeconds(seconds: Int(time)).2)
                
            }
        }
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
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
        let artistName = self.immamPlay!.data![currentPlayingIndex].audioTitle
        let songName = self.immamPlay!.data![currentPlayingIndex].audioArtist
        
        
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyArtist] = artistName!
        nowPlayingInfo[MPMediaItemPropertyTitle] = songName!
        
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
    // This shows media info on lock screen - used currently and perform controls
 /*   func showMediaInfo(){
        let artistName = self.immamPlay!.data![currentPlayingIndex].audioName
        let songName = self.immamPlay!.data![currentPlayingIndex].audioArtist
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyArtist : artistName,  MPMediaItemPropertyTitle : songName]
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event!.type == UIEventType.remoteControl{
            switch event!.subtype{
            case UIEventSubtype.remoteControlPlay:
                play(self)
            case UIEventSubtype.remoteControlPause:
                play(self)
            case UIEventSubtype.remoteControlNextTrack:
                next(self)
            case UIEventSubtype.remoteControlPreviousTrack:
                previous(self)
            default:
                print("There is an issue with the control")
            }
        }
    }*/
}

extension PlayerVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.immamPlay?.data?.count != nil {
            return self.immamPlay!.data!.count
        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell.delegatePlayer = self
        cell.lblTitle.text = self.immamPlay!.data![indexPath.row].audioTitle!
        cell.lblSubTitle.text = self.immamPlay!.data![indexPath.row].audioArtist!
        if self.immamPlay!.data![indexPath.row].favoriteFlag! == true {
            cell.btnFavourite.setImage(#imageLiteral(resourceName: "like"), for: UIControlState.normal)
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tblPlayer.deselectRow(at: indexPath, animated: true)
        currentPlayingIndex = indexPath.row
        self.callConfigurablePlayer()
        
    }
    
}

extension PlayerVC : PlayerDelegate {
    func Favourite(cell: PlayerCell) {
       
        let index = self.tblPlayer.indexPath(for: cell)
       let audioID =  self.immamPlay!.data![index!.row].audioId!
        print(appDelegate.identifierForAdvertising()!)
        SVProgressHUD.show()
        let para = ["user_token_id" : appDelegate.identifierForAdvertising()!, "audio_id" : audioID , "sub_category_id" : subCatID]
        postDataFromUrl(url: finalUrl.addFavourite, headers: languageDefault == 0 ? headersEnglish : headersArabic, parameters: para, completionHandler: { (json) in
            SVProgressHUD.dismiss()
        
            cell.btnFavourite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
        
    }
    
    func DownLoadClick(cell: PlayerCell) {
        let index = self.tblPlayer.indexPath(for: cell)
        if self.immamPlay?.data?[index!.row].audioName == nil {
            downLoad(url:self.immamPlay!.data![index!.row].audioUrl!)
        }else {
            downLoad(url:self.immamPlay!.data![index!.row].audioName!)
        }
        
    }
}
