//
//  YouTubeVC.swift
//  Haramain
//
//  Created by naman on 14/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
class YouTubeVC: UIViewController {

    @IBOutlet var btnBack: UIButton!
    @IBOutlet var youTubeView: YTPlayerView!
    var catID = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        var url = ""
        if catID == "1" {
            url = appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.videoUrl!
        }else {
            url = appDelegate.mosqueMainModel!.data!.masjidAlNabawi!.videoUrl!
        }
        if let videoID = url.components(separatedBy: "=").last {
            print(videoID)
            self.youTubeView.load(withVideoId:videoID)
            self.youTubeView.backgroundColor = UIColor.black
            self.youTubeView.setPlaybackQuality(.auto)
        }
       
    }
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
   

}
extension YouTubeVC : YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.youTubeView.playVideo()
    }
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print(error)
    }
}
