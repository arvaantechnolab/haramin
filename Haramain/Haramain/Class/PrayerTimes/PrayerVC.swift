//
//  PrayerVC.swift
//  Haramain
//
//  Created by naman on 29/01/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit
import SVProgressHUD
import SJSwiftSideMenuController

class PrayerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    
    @IBOutlet weak var ivBackGround: UIImageView!
    @IBOutlet weak var btnMenuRight: UIButton!
    @IBOutlet weak var btnMenuLeft: UIButton!
    @IBOutlet var txtTitle: UITextField!
    @IBOutlet var txtDate: UITextField!
   
    @IBOutlet var lblFajrStart: UILabel!
    @IBOutlet var lblFajrJamah: UILabel!
    @IBOutlet var lblSunriseStart: UILabel!
    @IBOutlet var lblSunriseJamah: UILabel!
    @IBOutlet var lblZuhrStart: UILabel!
    @IBOutlet var lblZuhrJamah: UILabel!
    @IBOutlet var lblAsrStart: UILabel!
    @IBOutlet var lblAsrJamah: UILabel!
    @IBOutlet var lblMaghribStart: UILabel!
    @IBOutlet var lblMaghribJamah: UILabel!
    @IBOutlet var lblIshaStart: UILabel!
    @IBOutlet var lblIshaJamah: UILabel!


    @IBOutlet var lblTitleStart: UILabel!
    @IBOutlet var lblTitleJamah: UILabel!
    @IBOutlet var lblTitleNote: UILabel!

    @IBOutlet var lblTitleFajr: UILabel!
    @IBOutlet var lblTitleSunrise: UILabel!
    @IBOutlet var lblTitleZuhr: UILabel!
    @IBOutlet var lblTitleAsr: UILabel!
    @IBOutlet var lblTitleMaghrib: UILabel!
    @IBOutlet var lblTitleIsha: UILabel!

    var arrData : [PrayerBaseClass] = []
    
    var catID:String = "1"
    var year = ""
    
    var placePicker: UIPickerView = UIPickerView()
    var titlePicker: UIPickerView = UIPickerView()
    var datePicker: UIDatePicker = UIDatePicker()
    var CurrentDate:String = ""
    var DefaultDate:String = ""
     var prayerModel : PrayerBaseClass?
    var arrTitleList:[CategoryPrayerModel] = []

    let arrName = ["FAJR","SUNRISE","ZUHR","ASR","MAGHRIB","ISHA"]
    let arrNameArabic = ["صلاة الفجر","شروق الشمس","صلاة الظهر","صلاة العصر","صلاة المغرب","صلاة العشاء"]
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        placePicker.delegate = self
        placePicker.dataSource = self
        
        titlePicker.delegate = self
        titlePicker.dataSource = self
    
        txtTitle.inputView = titlePicker
       
        // Get Current Date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let result = formatter.string(from: date)
        txtDate.text = result
        formatter.dateFormat = "yyyy-MM-DD"
        CurrentDate = Utilities.convertDateToString(date, dateFormat: "yyyy-MM-dd")!
        
        // DatePicker
        datePicker.datePickerMode = .date
        txtDate.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
       
        // pickup toolbar
        pickUp(txtDate)
        pickUp(txtTitle)
        
        //CategoryPrayerModel
        let obj1 = CategoryPrayerModel(id: "1", Name: "MASJID AL HARAM")
        let obj2 = CategoryPrayerModel(id: "2", Name: "MASJID AN NABAWI")
        arrTitleList.append(obj1)
        arrTitleList.append(obj2)
        
        if languageDefault == 0 {
            btnMenuLeft.isHidden = false
            btnMenuRight.isHidden = true
        }else {
            btnMenuRight.isHidden = false
            btnMenuLeft.isHidden = true
        }
       
        self.navigationController?.isNavigationBarHidden = true
        
        //Call Category Id and year you can change from any where
        getMosqueList(cateGoryID: catID,month : getMonthName(date: Date()), year: String(describing: getYear(date: Date()).year!))
         //self.data(0, currntDate: CurrentDate)
        // Do any additional setup after loading the view.
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
        lblTitleFajr.text = getTitle(index: 0, isEnglish: languageDefault == 0)
        lblTitleSunrise.text = getTitle(index: 1, isEnglish: languageDefault == 0)
        lblTitleZuhr.text = getTitle(index: 2, isEnglish: languageDefault == 0)
        lblTitleAsr.text = getTitle(index: 3, isEnglish: languageDefault == 0)
        lblTitleMaghrib.text = getTitle(index: 4, isEnglish: languageDefault == 0)
        lblTitleIsha.text = getTitle(index: 5, isEnglish: languageDefault == 0)
        
        lblTitleStart.text = languageDefault == 0 ? "START" : "ابدأ"
        lblTitleJamah.text = languageDefault == 0 ? "JAMA'AH" : "الجماعة"
        lblTitleNote.text = languageDefault == 0 ? "Jama'ah times may change during peak seasons" : "أوقات الجماعة ستختلف في المواسم الذروة"
    }
    
    func getTitle(index: Int, isEnglish: Bool) -> String {
        return isEnglish == true ? arrName[index] : arrNameArabic[index]
    }
    
    func pickUp(_ textField : UITextField){
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PrayerVC.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    //MARK:- Button
    @objc func doneClick() {
        txtDate.resignFirstResponder()
        txtTitle.resignFirstResponder()
    }
    
    //MARK:- TextFiled Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DefaultDate = txtDate.text!
        self.pickUp(txtDate)
        self.pickUp(txtTitle)
    }
    
    //MARK:- Picker Method
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrTitleList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrTitleList[row].categoryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtTitle.text = arrTitleList[row].categoryName
        catID = arrTitleList[row].categoryId!
        if txtTitle.text == "MASJID AL HARAM" {
            ivBackGround.image = #imageLiteral(resourceName: "makkah")
             getMosqueList(cateGoryID: catID,month : getMonthName(date: Date()), year: String(describing: getYear(date: Date()).year!))
          
        }else if txtTitle.text == "MASJID AN NABAWI" {
            ivBackGround.image = #imageLiteral(resourceName: "medina_latest")
            getMosqueList(cateGoryID: catID,month : getMonthName(date: Date()), year: String(describing: getYear(date: Date()).year!))
           
        }
        txtTitle.resignFirstResponder()
    }
    
    // Date picker
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        if sender == datePicker {
            dateFormatter.dateFormat = "dd MMM yyyy"
             txtDate.text = dateFormatter.string(from: datePicker.date)
            
            txtDate.resignFirstResponder()
            
            if DefaultDate != txtDate.text {
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                let date1 = dateFormatter.date(from:txtDate.text!)!
                
                dateFormatter.dateFormat = "dd MMM yyyy"
                let date2 = dateFormatter.date(from:DefaultDate)!
                
                dateFormatter.dateFormat = "yyyy-MM-DD"
                CurrentDate = Utilities.convertDateToString(date1, dateFormat: "yyyy-MM-dd")!
                
                self.data(0, currntDate: CurrentDate)
                dateFormatter.dateFormat = "MMM"
                let currentMonth = dateFormatter.string(from: date1)
                
                dateFormatter.dateFormat = "MMM"
                let newMonth = dateFormatter.string(from: date2)
               
                if currentMonth != newMonth {
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                let date1 = dateFormatter.date(from:txtDate.text!)!
            
                dateFormatter.dateFormat = "yyyy-MM-DD"
                CurrentDate = Utilities.convertDateToString(date1, dateFormat: "yyyy-MM-dd")!
                 
            getMosqueList(cateGoryID: catID,month : getMonthName(date: date1), year: String(describing: getYear(date: date1).year!))
                self.data(0, currntDate: CurrentDate)
                }
                
                dateFormatter.dateFormat = "yyyy"
                let currentYear = dateFormatter.string(from: date1)
               
                dateFormatter.dateFormat = "yyyy"
                let newYear = dateFormatter.string(from: date2)
                
                if currentYear != newYear {
                    
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMM yyyy"
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    let date1 = dateFormatter.date(from:txtDate.text!)!
                  
                    dateFormatter.dateFormat = "yyyy-MM-DD"
                    CurrentDate = Utilities.convertDateToString(date1, dateFormat: "yyyy-MM-dd")!
                   
                    getMosqueList(cateGoryID: catID,month : getMonthName(date: date1), year: String(describing: getYear(date: date1).year!))
                    self.data(0, currntDate: CurrentDate)
                }
            }else{
             dateFormatter.dateFormat = "yyyy-MM-DD"
            CurrentDate = dateFormatter.string(from: datePicker.date)
            
            self.data(0, currntDate: CurrentDate)
            }
            
            dateFormatter.dateFormat = "yyyy-MM-DD"
            CurrentDate = dateFormatter.string(from: datePicker.date)
            self.data(0, currntDate: CurrentDate)
        }
    }
    
    
    // MARK: - Button
    
    @IBAction func btnRightClick(_ sender: Any) {
         SJSwiftSideMenuController.toggleRightSideMenu()
    }
    @IBAction func btnLeftClick(_ sender: Any) {
         SJSwiftSideMenuController.toggleLeftSideMenu()
    }
   
   // MARK: - Get NextDay Function
        func getNextDay() -> Date? {
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let date1 = dateFormatter.date(from:txtDate.text!)!
            
            dateFormatter.dateFormat = "yyyy-MM-DD"
            CurrentDate = Utilities.convertDateToString(date1, dateFormat: "yyyy-MM-dd")!
           
            self.data(0, currntDate: CurrentDate)
            
            let previousDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: 1, to: date1)
            
            txtDate.text = formatter.string(from: previousDate!)
            
            dateFormatter.dateFormat = "MMM"
            let currentMonth = dateFormatter.string(from: date1)
           
            dateFormatter.dateFormat = "MMM"
            let newMonth = dateFormatter.string(from: previousDate!)
            
            if currentMonth != newMonth {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                dateFormatter.timeZone = TimeZone.autoupdatingCurrent
                
                let date2 = dateFormatter.date(from:txtDate.text!)!
              
                CurrentDate = Utilities.convertDateToString(date2, dateFormat: "yyyy-MM-dd")!
                
                self.data(0, currntDate: CurrentDate)
                let previousDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: 1, to: date2)
                getMosqueList(cateGoryID: catID,month : getMonthName(date: previousDate!), year: String(describing: getYear(date: previousDate!).year!))
                
            }else{
                self.data(0, currntDate: CurrentDate)
            }
            
            dateFormatter.dateFormat = "yyyy"
            let currentYear = dateFormatter.string(from: date1)
         
            dateFormatter.dateFormat = "yyyy"
            let newYear = dateFormatter.string(from: previousDate!)
           
            if currentYear != newYear {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                dateFormatter.timeZone = TimeZone.autoupdatingCurrent
                
                let date2 = dateFormatter.date(from:txtDate.text!)!
               
                CurrentDate = Utilities.convertDateToString(date2, dateFormat: "yyyy-MM-dd")!
               
                self.data(0, currntDate: CurrentDate)
                let previousDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: 1, to: date2)
                getMosqueList(cateGoryID: catID,month : getMonthName(date: previousDate!), year: String(describing: getYear(date: previousDate!).year!))
               
            }else{
                self.data(0, currntDate: CurrentDate)
            }
            
            return previousDate
        }

    
    // MARK: - Get PreviousDay Function
        func getPreviousDay() -> Date? {
           
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let date1 = dateFormatter.date(from:txtDate.text!)!
          
            dateFormatter.dateFormat = "yyyy-MM-DD"
            CurrentDate = Utilities.convertDateToString(date1, dateFormat: "yyyy-MM-dd")!
            
            self.data(0, currntDate: CurrentDate)
            
            let previousDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: date1)
            
            txtDate.text = formatter.string(from: previousDate!)
          
            dateFormatter.dateFormat = "MMM"
            let currentMonth = dateFormatter.string(from: date1)
          
            dateFormatter.dateFormat = "MMM"
            let newMonth = dateFormatter.string(from: previousDate!)
           
            if currentMonth != newMonth {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                dateFormatter.timeZone = TimeZone.autoupdatingCurrent
                
                let date2 = dateFormatter.date(from:txtDate.text!)!
            
                CurrentDate = Utilities.convertDateToString(date2, dateFormat: "yyyy-MM-dd")!
              
                self.data(0, currntDate: CurrentDate)
                let previousDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: date2)
                getMosqueList(cateGoryID: catID,month : getMonthName(date: previousDate!), year: String(describing: getYear(date: previousDate!).year!))
               
            }else{
                self.data(0, currntDate: CurrentDate)
            }
            
            dateFormatter.dateFormat = "yyyy"
            let currentYear = dateFormatter.string(from: date1)
           
            dateFormatter.dateFormat = "yyyy"
            let newYear = dateFormatter.string(from: previousDate!)
           
            if currentYear != newYear {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                dateFormatter.timeZone = TimeZone.autoupdatingCurrent
                
                let date2 = dateFormatter.date(from:txtDate.text!)!
              
                CurrentDate = Utilities.convertDateToString(date2, dateFormat: "yyyy-MM-dd")!
              
                self.data(0, currntDate: CurrentDate)
                let previousDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: date2)
                getMosqueList(cateGoryID: catID,month : getMonthName(date: previousDate!), year: String(describing: getYear(date: previousDate!).year!))
            }else{
                self.data(0, currntDate: CurrentDate)
            }
            
            return previousDate
        }
    
    // MARK: - Button Previous
    
    @IBAction func btnPrevious(_ sender: UIButton) {
        getPreviousDay()
    }
    
    // MARK: - Button Next
    
    @IBAction func btnNext(_ sender: UIButton) {
        getNextDay()
    }
    
    // MARK: - Api
    
    func getMosqueList(cateGoryID : String,month : String , year : String ){
        SVProgressHUD.show()
        
        let parameter = ["category_id" : cateGoryID , "month" : month,"year" : year]
       print(parameter)
        let prayerUrl = finalUrl.prayerTimes + parameter.queryString()
        getDataFromUrl(url: prayerUrl, headers: languageDefault == 0 ? headersEnglish : headersArabic, completionHandler: { (json) in
           
            self.prayerModel = PrayerBaseClass(json: json)
            
            print("Prayer Data",self.prayerModel!.data![0])
            print(self.CurrentDate)
            self.data(0, currntDate: self.CurrentDate)
            SVProgressHUD.dismiss()
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: - Response Data
    
    func data(_ itemIndex:Int , currntDate:String){
        
        if prayerModel?.data?.first?.day != nil
        {
        for data in (prayerModel?.data)!
        {
            if currntDate == data.date
            {
                    lblFajrStart.text = data.fajr
                    lblFajrJamah.text = data.fajrJamma
                    lblSunriseStart.text = data.sunrise
                    lblSunriseJamah.text = data.sunriseJamma
                    lblZuhrStart.text = data.dhuhar
                    lblZuhrJamah.text = data.dhuharJamma
                    lblAsrStart.text = data.asr
                    lblAsrJamah.text = data.asrJamma
                    lblMaghribStart.text = data.maghrib
                    lblMaghribJamah.text = data.maghribJamma
                    lblIshaStart.text = data.isha
                    lblIshaJamah.text = data.ishaJamma
            }
        }
        }}

}


