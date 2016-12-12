//
//  Extensions.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //Method used for getting random color. The fun is off the charts...
    static func generateRandomColor() -> UIColor {
        
        let r = Float(drand48())
        let g = Float(drand48())
        let b = Float(drand48())
        
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: 1.0)
        
    }
    
}

extension Double {
    
    //Method used to round the digits of a number to two decimals
    func roundToNearestValue(value: Double) -> Double {
        
        let remainder = self.truncatingRemainder(dividingBy: value)
        let shouldRoundUp = remainder >= value/2 ? true : false
        let multiple = floor(self / value)
        let returnValue = !shouldRoundUp ? value * multiple : value * multiple + value
        return returnValue
        
    }
}
