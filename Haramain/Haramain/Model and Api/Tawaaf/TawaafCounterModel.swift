//
//  TawaafCounterModel.swift
//  Haramain
//
//  Created by Arvaan on 01/02/18.
//  Copyright © 2018 naman. All rights reserved.
//

import UIKit

class TawaafCounterModel: NSObject {

    var name:String?
    var time:String?
    
    
    init(id:String , Name:String)
    {
        self.name = id
        self.time  = Name
        
    }
    
}
