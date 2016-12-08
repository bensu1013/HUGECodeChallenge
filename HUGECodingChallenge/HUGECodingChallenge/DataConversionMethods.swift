//
//  DataConversionMethods.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation

struct DataModel {
    
    static func changeDoubleToMoney(amount: Double) -> Double {
        
        return Double(round(amount * 100) / 100)
        
    }
    
}
