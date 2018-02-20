//
//  CategoryPrayerModel.swift
//  Haramain
//
//  Created by Arvaan on 30/01/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class CategoryPrayerModel: NSObject {
    
    var categoryId:String?
    var categoryName:String?
    
    
    init(id:String , Name:String)
    {
        self.categoryId = id
        self.categoryName  = Name
        
    }
}
