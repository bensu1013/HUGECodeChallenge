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
    
    static func generateRandomColor() -> UIColor {
        
        let r = Float(drand48())
        let g = Float(drand48())
        let b = Float(drand48())
        
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: 1.0)
        
    }
    
}
