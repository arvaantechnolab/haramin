//
//  AppConstant.swift
//  Haramain
//
//  Created by naman on 25/01/18.
//  Copyright © 2018 naman. All rights reserved.
//

import Foundation
import UIKit
// make 0 for english and 1 for Arabic
var languageDefault : Int = 0 


struct languageLabel {
    static let app_name = languageDefault == 0 ? "Haramain Recordings" : "تسجيلات الحرمين"
   
    static let app_shared_pref = languageDefault == 0 ? "HaramainSharedPref" : ""
    static let masjid_an_haram = languageDefault == 0 ? "Masjid Al Haram" : "المسجد الحرام"
    static let masjid_an_nabawi = languageDefault == 0 ? "Masjid An Nabawi" : "المسجد النبوي"
    static let makkah_daily_salaah = languageDefault == 0 ? "Makkah Daily Salaah" : "مكة المكرمة اليومية"
    static let madeenah_daily_salaah = languageDefault == 0 ? "Madeenah Daily Salaah" : "مدینة الصلاحیة الیومیة"
    static let masjid = languageDefault == 0 ? "Masjid" : "المسجد"
    static let gallery = languageDefault == 0 ? "Gallery" : "معرض الصور"
    static let galleryImage = languageDefault == 0 ? "Gallery" : "Gallery"
    static let error_player = languageDefault == 0 ? "There was an error initializing the YouTubePlayer (%1$s)" : "خطأ في ابتداء يو تيوب"
    static let no_data_available = languageDefault == 0 ? "No data available" : "لا توجد أي معلومة"
    static let read_more = languageDefault == 0 ? "Read more..." : "Read more..."
    static let recite_quran = languageDefault == 0 ? "Recite Quran" : ""
    static let images_haram = languageDefault == 0 ? "Masjid Al Haram Images" : ""
    static let images_nabawi = languageDefault == 0 ? "Masjid An Nabawi Images" : ""
    static let circumambulation_time = languageDefault == 0 ? "Circumambulation Time" : "مدة الطواف"
    static let total_time = languageDefault == 0 ? "Total time" : "مدة كاملة"
    static let haramainGps = languageDefault == 0 ? "Haramain GPS" : "تتبع نظام تحديد المواقع"
    static let haramainGpsImage = languageDefault == 0 ? "Haramain GPS" : "Haramain GPS"
    static let ok = languageDefault == 0 ? "Ok" : "حسنا"
}


struct sideMenuStringEnglish {
    
    static let home =  "Home"
    static let aboutUs = "About Us"
    static let favourite = "Favourites"
    static let prayerTime = "Prayer Times"
    static let makkah_daily_salaah = "Makkah Daily Salaah"
    static let madeenah_daily_salaah = "Madeenah Daily Salaah"
    static let iMaamsSchedule = "Imaams Schedule"
    static let ReadQuran =  "Read Qur'an"
    static let contactUs = "Contact Us"
}

struct sideMenuStringArabic {
    
    static let home =  "الرئيسية"
    static let aboutUs = "نبذة عنا"
    static let favourite =  "المفضلة"
    static let prayerTime =  "أوقات الصلاة"
    static let makkah_daily_salaah =  "مكة المكرمة اليومية"
    static let madeenah_daily_salaah =  "مدینة الصلاحیة الیومیة"
    static let iMaamsSchedule =  "جدول الأئمة"
    static let ReadQuran =  "اتل القرآن"
    static let contactUs =  "اتصل بنا"
}

func showAlert(){
    
    let alert = UIAlertController(title: languageLabel.app_name, message: languageLabel.no_data_available, preferredStyle: UIAlertControllerStyle.alert)
   
    appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    alert.addAction(UIAlertAction(title: languageLabel.ok, style:.default, handler: nil))
}

