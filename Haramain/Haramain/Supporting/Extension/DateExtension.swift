//
//  DateExtension.swift
//  Haramain
//
//  Created by naman on 29/01/18.
//  Copyright © 2018 naman. All rights reserved.
//

import Foundation


    
    
    func getMonthName(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        let strMonth = dateFormatter.string(from: date)
        return strMonth
    }


    func getYear(date : Date) -> DateComponents {
       
        let calendar = Calendar.current
        let components = Set<Calendar.Component>([.month, .year])
        let dateWithComponents = calendar.dateComponents(components, from: date)
        
        return dateWithComponents
    }
    
    

