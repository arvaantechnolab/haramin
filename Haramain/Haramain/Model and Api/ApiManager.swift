//
//  ApiManager.swift
//  Haramain
//
//  Created by naman on 13/01/18.
//  Copyright © 2018 naman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD
typealias ApiCompletionHandler = (_ json : JSON) -> Void;
typealias ApiFailuerHandler = (_ error : Error) -> Void;

let baseURL = "http://haramain360.com/api_v1/v2/index.php/"

struct FolderName {
    static let mosque = "mosque"
    static let favorites = "favorites"
    static let gallery = "gallery"
    static let gpslocation = "gpslocation"
    static let prayer = "prayer"
}

struct ApiNames {
    static let mosqueList = "getMosqueList"
    static let liveFriday = "getLiveFridayKhutbahLanguages?"
    static let ImaamList = "getImaamList?"
    static let ImaamRecitation = "getImaamRecitation?"
    static let MuadhinsList = "getMuadhinsList?"
    static let MuadhinsAdhaan = "getMuadhinsAdhaan?"
    static let PreviousKhutbahYear = "getPreviouskhutbahYear?"
    static let getPrayerTimes = "getPrayerTimes"
    static let getPreviousTaraweeh = "getPreviousTaraweehYear?"
    static let getPreviousTaraweehAudio = "getPreviousTaraweehData?"
    static let getImages = "getImages?"
    static let getPreLanguages = "getPreLanguages?"
    static let getPreviousKhutbahAudio = "getPreviousKhutbah?"
    static let getGpsHeadings = "getHeadings?"
    static let getGpsSubHeadings = "getSubHeadings?"
    static let addToFavourite = "add"
    static let getFavouriteList = "get?"
    static let removeFavourite = "remove"
}

var headersArabic = ["clientkey" : "e2c212e380fb32258d8a29a8a95d5ea21a5f264d" , "clientsecret" : "fdd1a57ab44b8c716dbad93ac4fb5032e235288a", "lang" : "ar"]

var headersEnglish = ["clientkey" : "e2c212e380fb32258d8a29a8a95d5ea21a5f264d" , "clientsecret" : "fdd1a57ab44b8c716dbad93ac4fb5032e235288a", "lang" : "en"]

enum finalUrl {
    static let mosqueList = baseURL + "/" + FolderName.mosque + "/" + ApiNames.mosqueList
    static let FridayKhutbah = baseURL + "/" + FolderName.mosque + "/" + ApiNames.liveFriday
    static let ImmamList = baseURL + "/" + FolderName.mosque + "/" + ApiNames.ImaamList
    static let ImmamAudio = baseURL + "/" + FolderName.mosque + "/" + ApiNames.ImaamRecitation
    static let MuadhinsList = baseURL + "/" + FolderName.mosque + "/" + ApiNames.MuadhinsList
    static let MuadhinAudioList = baseURL + "/" + FolderName.mosque + "/" + ApiNames.MuadhinsAdhaan
    static let PreviousKhutbahYear = baseURL + "/" + FolderName.mosque + "/" + ApiNames.PreviousKhutbahYear
    static let prayerTimes = baseURL + "/" + FolderName.prayer + "/" + ApiNames.getPrayerTimes + "?"
    static let Taraweeh = baseURL + "/" + FolderName.mosque + "/" + ApiNames.getPreviousTaraweeh
    static let TaraweehAudio = baseURL + "/" + FolderName.mosque + "/" + ApiNames.getPreviousTaraweehAudio
    static let GalleryImages = baseURL + "/" + FolderName.gallery + "/" + ApiNames.getImages
    static let previousKhutbh = baseURL + "/" + FolderName.mosque + "/" + ApiNames.PreviousKhutbahYear
    static let previousLanguage = baseURL + "/" + FolderName.mosque + "/" + ApiNames.getPreLanguages
    static let previousFridayAudio = baseURL + "/" + FolderName.mosque + "/" + ApiNames.getPreviousKhutbahAudio
    static let gpsHeadings = baseURL + "/" + FolderName.gpslocation + "/" + ApiNames.getGpsHeadings
    static let gpsSubHeadings = baseURL + "/" + FolderName.gpslocation + "/" + ApiNames.getGpsSubHeadings
    static let haramainDaily = "http://haramain.quranicaudio.com/api/v1/shuyookh/"
    static let makkahDaily = "http://haramain.quranicaudio.com/api/v1/latest"
    static let madiNahDaily = ""
    static let addFavourite = baseURL + "/" + FolderName.favorites + "/" + ApiNames.addToFavourite
    static let getFavouriteList = baseURL + "/" + FolderName.favorites + "/" + ApiNames.getFavouriteList
    static let removeFavouriteURL = baseURL + "/" + FolderName.favorites + "/" + ApiNames.removeFavourite
 }



func getDataFromUrl(url : String ,headers : [String : String], completionHandler : @escaping ApiCompletionHandler , failureHandler : @escaping ApiFailuerHandler) {
    
    if (!MTReachabilityManager.isReachable()){
        SVProgressHUD.showError(withStatus: "Please try again , There is network error")
        return
    }
    Alamofire.request(url, headers: headers).validate().responseJSON { response in
       
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print("JSON: \(json)")
            completionHandler(json)
          
        case .failure(let error):
            print(error)
            failureHandler(error)
        }
    }

}
func postDataFromUrl(url : String ,headers : [String : String],parameters : [String : String], completionHandler : @escaping ApiCompletionHandler , failureHandler : @escaping ApiFailuerHandler) {
    
    if (!MTReachabilityManager.isReachable()){
        SVProgressHUD.showError(withStatus: "Please try again , There is network error")
        return
    }
    
    Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
        
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print("JSON: \(json)")
            completionHandler(json)
            
        case .failure(let error):
            print(error)
            failureHandler(error)
        }
    }
    
    
}


func downLoad(url : String) {
    let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
    
    Alamofire.download(
        url,
        method: .get,
        parameters: nil,
        encoding: JSONEncoding.default,
        headers: nil,
        to: destination).downloadProgress(closure: { (progress) in
            //progress closure
            DispatchQueue.main.async {
                SVProgressHUD.showProgress(Float(progress.completedUnitCount))
                print(progress.completedUnitCount)
            }
            
        }).response(completionHandler: { (DefaultDownloadResponse) in
            //here you able to access the DefaultDownloadResponse
            //result closure
            DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            }
            
           
        })
}
