//
//  Utilities.swift
//  DayDate
//
//  Created by Mehul Thakkar on 12/01/16.
//  Copyright © 2016 ArvaanTechnolabs. All rights reserved.
//

import UIKit
import CoreLocation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


let kUserDetail = "UserDetail";
let kUserSearchSettings = "searchSettings";
let kAccessToken = "accessToken"
private let conversionValForCmToInch = 0.393701;
let dateTimeFormat = "yyyy-MM-dd"
let StringdateTimeFormat = "dd-MM-yyyy"

enum AlertType : Int {
    
    case success = 0
    case failure = 1
    case internet_ERROR = 2
}

class Utilities: NSObject
{
  
    
    class func queryString (_ dic : NSDictionary) -> String{

        var queryString : String = ""
        var i = 0;

        for (key,value) in dic {

            if (i == 0){
                queryString += "\(key)=\(value)"
            }else{
                queryString += "&\(key)=\(value)"
            }
            i += 1
        }
        return queryString
    }

    
    class func readFile(_ fileURL : URL) -> Data?
    {
        do
        {
            let strData = try Data(contentsOf: fileURL)
            return strData;
        }catch
        {
            print("Error in file reading \(fileURL)")
        }
        
        return nil;
    }
    
    class func makeJsonData(_ object:AnyObject) -> Data?
    {
        do
        {
            let data = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions())
            return data;
        }catch
        {
            print("can not make json of \(object)");
        }
        
        return nil;
    }
    
    
    class func convertDateString(_ dateStr:String?, fromDateFormat currentFormat:String, toDateFormat newFormat:String) -> String?
    {
        if dateStr == nil
        {
            return nil;
        }
        
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = currentFormat;
        let date = formatter.date(from: dateStr!);
        if date == nil
        {
            return "";
        }
        formatter.dateFormat = newFormat;
        let newStr : String = formatter.string(from: date!);
        return newStr;
    }
    
    class func convertStringToDate(_ strDate:String, dateFormat:String) -> Date?
    {
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = dateFormat;
        formatter.timeZone = TimeZone.autoupdatingCurrent
        let date = formatter.date(from: strDate);
        return date;
    }
    
    class func convertUTCStringToDate(_ strDate:String, dateFormat:String) -> Date?
    {
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = dateFormat;
        
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = formatter.date(from: strDate);
        return date;
    }
    
    class func convertGMTStringToDate(_ strDate:String, dateFormat:String) -> Date?
    {
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = dateFormat;
        
        formatter.timeZone = TimeZone(identifier: "GMT-2")
        let date = formatter.date(from: strDate);
        return date;
    }
    
    
    class func convertUTCDateToString(_ date:Date, dateFormat:String) -> String?
    {
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = dateFormat;
        formatter.timeZone = TimeZone(identifier: "UTC")
        let str = formatter.string(from: date);
        return str;
    }
    
    class func convertDateToString(_ date:Date, dateFormat:String) -> String?
    {
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = dateFormat;
        formatter.timeZone = TimeZone.autoupdatingCurrent
        let str = formatter.string(from: date);
        return str;
    }
    
    class func convertCMToInch(_ inch : Float) -> Float{
        return  Float(conversionValForCmToInch) * Float(inch);
    }
    
    class func getDayOfWeek(_ date:Date)-> String {
        
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = "EEEE";
        formatter.timeZone = TimeZone.autoupdatingCurrent
        let str = formatter.string(from: date);
        return str;
    }

    class func floatingValueOfTime(_ strTime : String) -> Float{
        let arr = strTime.components(separatedBy: ":") as NSArray;
        let hour = Float(arr.object(at: 0) as! String)!;
        let minute = Float(arr.object(at: 1) as! String)!;
        
        let time = hour + (minute / Float(60))
        return time
    }
    
    class func localize(_ string:String) -> String
    {
        return Utilities.localize(string, fileName: nil)
    }
    
    class func localize(_ string:String,fileName file:String?) -> String
    {
        if file == nil
        {
            return NSLocalizedString(string, comment: "")
        }
        else
        {
            return NSLocalizedString(string, tableName: file!, bundle: Bundle.main, value:"", comment: "")
        }
    }
    
    class func doubleRoundNumber(_ number : Double, roundTo : Int) -> Double{
        let division = pow(Double(10),Double(roundTo))
        let num1 = Int(division * number);
        let num2 = Double(Double(num1) / division);
        
        return num2;
    }
    
    class func floatRoundNumber(_ number : Float, roundTo : Int) -> Float{
        let division = pow(Double(10),Double(roundTo))
        let num1 = Int(division * Double(number));
        let num2 = Float(Double(num1) / division);
        
        return num2;
    }
    class func intRoundNumber(_ number : Float) -> Int{
        let division = pow(Double(10),Double(0))
        let num1 = Int(division * Double(number));
        let num2 = Int(Double(num1) / division);
        
        return num2;
    }
    
    class func saveObjectToUserDefaultsWithObject(_ object:AnyObject?, forKey key:String)
    {

        if object != nil {
            let defaults = UserDefaults.standard;
            defaults.set(object!, forKey: key);
            defaults.synchronize();
            
//            print("\(key) \(object)")
        }
    }
    
    class func getObjectFromUserDefaultsWithKey(_ key:String) -> AnyObject?
    {
        let defaults = UserDefaults.standard;
        return defaults.object(forKey: key) as AnyObject?;
    }
    
    class func timeIntervalInString(_ dateTime1 : Date,dateTime2 : Date) -> String{
        var timeInterval = dateTime1.timeIntervalSince(dateTime2)
        
        if timeInterval < 0 {
            timeInterval = -timeInterval;
        }
        timeInterval -= (2 * 60 * 60);
        
        if timeInterval < 0 {
            timeInterval = 0;
        }
        
        let totalMinute = Int(timeInterval / 60);
        let hours = totalMinute / 60;
        let minute = totalMinute - (hours * 60);
        
        let str = "\(hours):\(minute)";
        return str;
        
    }
    
    class func geocodeLocationWithlocation(_ location:CLLocation?, withCompletionHandler handler:@escaping ((_ status:Bool,_ address:String?,_ message:String?)->Void))
    {
        if location == nil
        {
            handler(false, nil, "Not able to get User Location, Please provide location access permission to app");
        }
        else if location!.coordinate.latitude == 0.0 && location!.coordinate.longitude == 0.0
        {
            handler(false, nil, "Not able to get User Location, Please provide location access permission to app");
        }
        else
        {
            let geocoder = CLGeocoder();
            
            geocoder.reverseGeocodeLocation(location!, completionHandler: { (placemarks, error) -> Void in
                
                if error != nil
                {
                    handler(false, nil, error?.localizedDescription);
                }
                else
                {
                    if placemarks != nil && placemarks?.count>0
                    {
                        let placeMark:CLPlacemark = placemarks![0];
                        
                        var address = "";
                        
                        if placeMark.name != nil
                        {
                            address = "\((placeMark.name)!)"
                        }
                        if placeMark.locality != nil
                        {
                            address = "\(address),\((placeMark.locality)!)"
                        }
                        if placeMark.subAdministrativeArea != nil
                        {
                            address = "\(address),\((placeMark.subAdministrativeArea)!)"
                        }
                        if placeMark.administrativeArea != nil
                        {
                            address = "\(address),\((placeMark.administrativeArea)!)"
                        }
                        handler(true, address, nil);
                    }
                    else
                    {
                        handler(true, " ", nil);
                    }
                }
            })
        }
    }
    
    class func getCategoryListInString(_ dicHotelDetail : NSMutableDictionary) -> String{
        
        var category = "";
        
        let arrCategory = dicHotelDetail.object(forKey: "categories") as? NSArray;
        var i = 0
        for item in arrCategory!{
            
            let categoryItem = item as? NSArray
            
            if categoryItem?.count > 0 {
                if i == 0 {
                    category = "\(categoryItem!.object(at: 0))"
                }
                else{
                    category = "\(category),\(categoryItem!.object(at: 0))"
                }
                
            }
            i += 1;
        }
        
        return category
    }
    
    class func makeMutableArray(_ arrObj : NSArray?) -> NSMutableArray{
        
        if arrObj == nil {
            return NSMutableArray()
        }
        
        let newObj = NSMutableArray()
        
        for i in 0..<arrObj!.count{
         
            let obj = arrObj!.object(at: i);
            
            if  obj is NSArray{
                newObj.add(Utilities.makeMutableArray(obj as? NSArray))
            }
            else if obj is NSDictionary{
                newObj.add(Utilities.makeMutableDictionary(obj as? NSDictionary))
            }
            else{
                newObj.add(obj)
            }
        }
        
        return newObj
    }
    
    class func makeMutableDictionary ( _ dicObj : NSDictionary?) -> NSMutableDictionary{
        
        if dicObj == nil {
            return NSMutableDictionary()
        }
        
        let newObj = NSMutableDictionary()
        let allKeys = dicObj!.allKeys as NSArray;
        
        for i in 0..<allKeys.count{
            let key = allKeys.object(at: i) as! String;
            let obj = dicObj!.object(forKey: key);
            
            if  obj is NSArray {
                
                newObj.setObject(Utilities.makeMutableArray(obj as? NSArray), forKey: key as NSCopying)
            }
            else if obj is NSDictionary{
                newObj.setObject(Utilities.makeMutableDictionary(obj as? NSDictionary), forKey: key as NSCopying)
            }
            else{
                newObj.setObject(obj!, forKey: key as NSCopying)
            }
        }
        
        return newObj
    }
    
    class func makeJsonFromObject(_ obj : AnyObject)
    {
        
    }
    
    class func needTestingLocation(_ location : CLLocation) -> Bool{
        let latitude = Utilities.floatRoundNumber(Float(location.coordinate.latitude), roundTo: 0)
        let longitude = Utilities.floatRoundNumber(Float(location.coordinate.longitude), roundTo: 0)
        
        if latitude == 23 && longitude == 72 {
            return true;
        }
        return false;
    }
    
    class func getHeightForTextView(_ textView: UITextView, forText strText: String) -> CGFloat {
        let temp: UITextView = UITextView(frame: textView.frame)
        temp.font = textView.font
        temp.text = strText
        let fixedWidth: CGFloat = temp.frame.size.width
        let newSize: CGSize = temp.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        return (newSize.height)
    }
    class func getHeightForLabel(_ label: UILabel) -> CGFloat {
        let temp: UILabel = UILabel(frame: label.frame)
        temp.font = label.font
        temp.text = label.text
        let fixedWidth: CGFloat = temp.frame.size.width
        let newSize: CGSize = temp.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        return (newSize.height)
    }
    
    
    class func randomStringWithLength (_ len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }
    
    class func printRequestDictionary(_ dic : NSDictionary){
        print("Request \n\n\n")
        for (key, value) in dic {
            print("\(key):\(value)")
        }
    }
    
    
    class func getTimeFromDateTime(_ strDate : String, strTime : String) -> String {
        let strDateTime = "\(strDate) \(strTime)"
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: dateTimeFormat)
        let time = Utilities.convertDateToString(date!, dateFormat: "HH:mm")
        return time!;
    }
    
    class func getDayFromDateTime(_ strDate : String, strTime : String) -> String {
        let strDateTime = "\(strDate) \(strTime)"
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: dateTimeFormat)
        var time = Utilities.convertDateToString(date!, dateFormat: "EEE")
        if time?.characters.count > 3 {
            time = time!.substring(to: time!.index(time!.startIndex, offsetBy: 3))
            
        }
        return time!;
    }
    class func getFullDateFromDateTime(_ strDate : String, strTime : String) -> String {
        let strDateTime = "\(strDate) \(strTime)"
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: dateTimeFormat)
        var time = Utilities.convertDateToString(date!, dateFormat: "yyyy-MM-DD")
//        if time?.characters.count > 3 {
//            time = time!.substring(to: time!.index(time!.startIndex, offsetBy: 3))
//
//        }
        return time!;
    }
    class func getMonthFromDate(_ strDate : String) -> String {
        let strDateTime = "\(strDate)"
        print(strDateTime)
        
        let date = Utilities.convertStringToDate(strDateTime.replacingOccurrences(of: " ", with: "-"), dateFormat: dateTimeFormat)
        print(date)
        var time = Utilities.convertDateToString(date!, dateFormat: dateTimeFormat)
//        if time?.characters.count > 3 {
//            time = time!.substring(to: time!.index(time!.startIndex, offsetBy: 3))
//        }
        return time!;
    }
    class func getFullMonthFromDate(_ strDate : String) -> String {
        let strDateTime = "\(strDate)"
        print(strDate)
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: StringdateTimeFormat)
        let time = Utilities.convertDateToString(date!, dateFormat: "MMMM")

        return time!;
    }
    class func getYearFromDate(_ strDate : String) -> String {
        let strDateTime = "\(strDate)"
        print(strDate)
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: StringdateTimeFormat)
        let time = Utilities.convertDateToString(date!, dateFormat: "yyyy")
        return time!;
    }
    class func getDateFromDate(_ strDate : String) -> String {
        let strDateTime = "\(strDate)"
        print(strDate)
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: StringdateTimeFormat)
        let time = Utilities.convertDateToString(date!, dateFormat: "dd")
        return time!;
    }
    class func getDateFromDate2(_ strDate : String) -> String {
        let strDateTime = "\(strDate)"
        print(strDate)
        let date = Utilities.convertStringToDate(strDateTime, dateFormat:dateTimeFormat)
        let time = Utilities.convertDateToString(date!, dateFormat: "dd")
        return time!;
    }
    class func getFullMonthFromDate2(_ strDate : String) -> String {
        let strDateTime = "\(strDate)"
        print(strDate)
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: dateTimeFormat)
        let time = Utilities.convertDateToString(date!, dateFormat: "MMMM")

        return time!;
    }
    class func getYearFromDate2(_ strDate : String) -> String {
        let strDateTime = "\(strDate)"
        print(strDate)
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: dateTimeFormat)
        let time = Utilities.convertDateToString(date!, dateFormat: "yyyy")
        return time!;
    }
    
    class func getMonthFromDateTime(_ strDate : String, strTime : String) -> String {
        let strDateTime = "\(strDate) \(strTime)"
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: dateTimeFormat)
        var time = Utilities.convertDateToString(date!, dateFormat: "MMM")
        if time?.characters.count > 3 {
            time = time!.substring(to: time!.index(time!.startIndex, offsetBy: 3))
        }
        return time!;
    }
    
    class func getDateFromDateTime(_ strDate : String, strTime : String) -> String {
        let strDateTime = "\(strDate) \(strTime)"
        let date = Utilities.convertStringToDate(strDateTime, dateFormat: dateTimeFormat)
        let time = Utilities.convertDateToString(date!, dateFormat: "dd")
        return time!;
    }
    class func getRealDateFromDateTime(_ strDate : String, strTime : String) -> Date {
        let strDateTime = "\(strDate) \(strTime)"
        let date = Utilities.convertUTCStringToDate(strDateTime, dateFormat: dateTimeFormat)
        return date!;
    }
        typealias dispatch_cancelable_closure = (_ cancel : Bool) -> Void
    
    class func delay(_ time:TimeInterval, closure:@escaping ()->Void) ->  dispatch_cancelable_closure? {
        
        func dispatch_later(_ clsr:@escaping ()->Void) {
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: clsr)
        }
        
        var closure:(()->())? = closure
        var cancelableClosure:dispatch_cancelable_closure?
        
        let delayedClosure:dispatch_cancelable_closure = { cancel in
            if closure != nil {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: closure as! @convention(block) () -> Void);
                }
            }
            closure = nil
            cancelableClosure = nil
        }
        
        cancelableClosure = delayedClosure
        
        dispatch_later {
            if let delayedClosure = cancelableClosure {
                delayedClosure(false)
            }
        }
        
        return cancelableClosure;
    }
    
    class func cancel_delay(_ closure:dispatch_cancelable_closure?) {
        
        if closure != nil {
            closure!(true)
        }
    }
    
    class func scaleObject(_ view:UIView,scale : CGSize){
        
        UIView.animate(withDuration: 0.1, animations: { 
            view.transform = CGAffineTransform( scaleX: scale.width, y: scale.height);
        }) 
    }
    
    class func makeBounceEffect(_ view : UIView,completion: @escaping () -> Void) {
        
        view.transform = CGAffineTransform( scaleX: 0.9, y: 0.9);
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
            
            view.transform = CGAffineTransform.identity
            
        }) { (flag) -> Void in
            completion()
        }
    }
    
    class func moveObjectFirst(_ index : NSInteger, arr : NSMutableArray )-> NSMutableArray {
        let newArr = NSMutableArray(array: arr)
        let obj = newArr.object(at: index)
        newArr.removeObject(at: index)
        newArr.insert(obj, at: 0)
        return newArr;
    }
    
    class func copyAndAppendArray(_ numberOfTime : NSInteger, arr : NSMutableArray )-> NSMutableArray {
        let newArr = NSMutableArray(array: arr)
        
        for i in 0..<numberOfTime{
            for dic in arr {
                newArr.add(dic);
            }
        }
        
        return newArr;
    }
    
    class func getViewControllerFromStoryboard(_ storyboard : String,identifire : String) -> UIViewController{
        let storyBoard = UIStoryboard(name: storyboard, bundle: nil);
        return storyBoard.instantiateViewController(withIdentifier: identifire);
    }
    class func getDataFrom(url : URL?) -> Data?{
        var data : Data?
        
        if url == nil {
            return nil
        }
        
        do {
            data = try Data(contentsOf: url!)
        }
        catch {
            print("error in fatching data")
        }

        return data

    }
    class func castStringFromArrayOfDict(arrCurrent : NSArray?, key : String, atIndex : NSInteger) -> String? {
        
        let str = (arrCurrent?.object(at: atIndex) as? NSDictionary)?.value(forKey: key) as? String
        return str
    }
    
    class func castDictionaryFromArrayOfDict(arrCurrent : NSArray?, atIndex : NSInteger) -> NSDictionary? {
        
        let dict = arrCurrent?.object(at: atIndex) as? NSDictionary
        return dict
    }
    class func resizeImage(_ image: UIImage, newHeight: CGFloat) -> UIImage {
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = UIImageJPEGRepresentation(newImage!, 0.5)! as Data
        UIGraphicsEndImageContext()
        return UIImage(data:imageData)!
    }


    

}
