//
//  AppDelegate.swift
//  Haramain
//
//  Created by naman on 07/01/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SwiftyJSON
import  SVProgressHUD
import SJSwiftSideMenuController
import AVFoundation
import AdSupport
let appDelegate = UIApplication.shared.delegate as! AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mosqueMainModel : MosqueBaseClass?
    var player = AVPlayer()
    var playerItem: AVPlayerItem!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let menuItemsEnglish = [sideMenuStringEnglish.home,sideMenuStringEnglish.aboutUs,sideMenuStringEnglish.favourite,sideMenuStringEnglish.prayerTime,sideMenuStringEnglish.makkah_daily_salaah,sideMenuStringEnglish.madeenah_daily_salaah,sideMenuStringEnglish.iMaamsSchedule,sideMenuStringEnglish.ReadQuran,sideMenuStringEnglish.contactUs]
          let menuItemsArabic = [sideMenuStringArabic.home,sideMenuStringArabic.aboutUs,sideMenuStringArabic.favourite,sideMenuStringArabic.prayerTime,sideMenuStringArabic.makkah_daily_salaah,sideMenuStringArabic.madeenah_daily_salaah,sideMenuStringArabic.iMaamsSchedule,sideMenuStringArabic.ReadQuran,sideMenuStringArabic.contactUs]
        
        let mainVC = SJSwiftSideMenuController()
        
        let sideVC_L : SideMenuController = (storyBoard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_L.menuItems = menuItemsEnglish as NSArray!
        
        let sideVC_R : SideMenuController = (storyBoard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_R.menuItems = menuItemsArabic as NSArray!
        
        let rootVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as UIViewController
        
        SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideOver)
        
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        
        SJSwiftSideMenuController.enableDimbackground = true
        SJSwiftSideMenuController.leftMenuWidth = 280
        //=======================================
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        if player.rate == 1.0 {
            player.play()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func identifierForAdvertising() -> String? {
        // Check whether advertising tracking is enabled
        guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else {
            return nil
        }
        
        // Get and return IDFA
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }

}

