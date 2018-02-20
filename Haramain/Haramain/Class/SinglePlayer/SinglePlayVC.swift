//
//  SinglePlayVC.swift
//  Haramain
//
//  Created by naman on 16/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import AVFoundation
class SinglePlayVC: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblCatName: UILabel!
    @IBOutlet var lblNowPlaying: UILabel!
    @IBOutlet var lblLiveFrom: UILabel!
    @IBOutlet var lblSongName: UILabel!
    @IBOutlet var ivMasjid: UIImageView!
    @IBOutlet var btnPlay: UIButton!
    var catID = ""
    var imageArray : [URL] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        if catID == "1" {
            lblLiveFrom.text = "Live From " + appDelegate.mosqueMainModel!.data!.masjidAlHaram!.categoryName!
            lblCatName.text = appDelegate.mosqueMainModel!.data!.masjidAlHaram!.categoryName!
            pageControl.numberOfPages =   appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage!.count
         
            for str in appDelegate.mosqueMainModel!.data!.masjidAlHaram!.catImage! {
                imageArray.append(URL(string: str)!)
            }
        }else {
        lblLiveFrom.text = "Live From " + appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.categoryName!
        lblCatName.text = appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.categoryName!
            pageControl.numberOfPages =  appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage!.count
       
            for str in appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.catImage! {
                imageArray.append(URL(string: str)!)
            }
        }
        ivMasjid.sd_setAnimationImages(with: imageArray)
        ivMasjid.animationDuration = 100
        self.startPlaying()
        pageControl.currentPage = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPlay(_ sender: Any) {
        if self.btnPlay.currentImage! == #imageLiteral(resourceName: "play_song") {
            appDelegate.player.play()
            self.btnPlay.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        }else {
            appDelegate.player.pause()
            self.btnPlay.setImage(#imageLiteral(resourceName: "play_song"), for: .normal)
            
        }
    }
    
    func startPlaying(){
        let urlString = catID == "1" ? appDelegate.mosqueMainModel?.data?.masjidAlHaram?.audioUrl! : appDelegate.mosqueMainModel?.data?.masjidAlNabawi?.audioUrl!
        appDelegate.playerItem = AVPlayerItem(asset: AVURLAsset(url: URL(string: urlString!)!))
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: appDelegate.playerItem)
        appDelegate.player = AVPlayer(playerItem: appDelegate.playerItem)
        appDelegate.player.play()
        self.btnPlay.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        appDelegate.player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if appDelegate.player.currentItem!.status == .readyToPlay {
                
            }
        }
    }
    
    @objc func playerItemDidPlayToEndTime() {
        // load next video or something
        self.btnPlay.setImage(#imageLiteral(resourceName: "play_song"), for: .normal)
    }
   
}
