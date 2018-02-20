//
//  CMSViewController.swift
//  Haramain
//
//  Created by Arvaan Techno-lab Pvt Ltd on 19/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController

class CMSViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var webViewCMS: UIWebView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    var strUrl : String = ""
    var strTitle: String = ""
    
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if languageDefault == 0 {
            //English
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            //Arabic
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        if strTitle.isEmpty == false {
            lblScreenTitle.text = strTitle
        }
        
        if strTitle == sideMenuStringEnglish.aboutUs || strTitle == sideMenuStringArabic.aboutUs {
            do {
                guard let filePath = Bundle.main.path(forResource: "information", ofType: "html")
                    else {
                        print ("File reading error")
                        return
                }
                
                let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
                let baseUrl = URL(fileURLWithPath: filePath)
//                webViewCMS.loadHTMLString(contents as String, baseURL: baseUrl)
                webViewCMS.loadHTMLString(String(format:"<html><head><link rel=\"stylesheet\" href=\"css/bootstrap.css\" type=\"text/css\"><link rel=\"stylesheet\" href=\"css/style.css\" type=\"text/css\"><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\" name=\"viewport\"></head><body>\(contents)</body></html>"), baseURL: baseUrl)
            }
            catch {
                print ("File HTML error")
            }
        }
        else if let url = URL(string: strUrl) {
            webViewCMS.loadRequest(URLRequest(url: url))
        }
    }
    
    
    //MARK: - IBActions
    @IBAction func btnMenuTapped(_ sender: UIButton) {
        if languageDefault == 0 {
            SJSwiftSideMenuController.toggleLeftSideMenu()
        }
        else {
            SJSwiftSideMenuController.toggleRightSideMenu()
        }

    }
    
    
    //MARK: - WebView Delegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        loader.isHidden = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loader.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        loader.isHidden = true
    }
}
