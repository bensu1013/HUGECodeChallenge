//
//  DataConversionMethods.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation

enum Country {
    
    case us, uk, eu, jp, br
    
}

final class DataModel {
    
    static let shared = DataModel()
    
    private init() {}
    
    var inputAmount: Double?
    var gbpRate: Double?
    var eurRate: Double?
    var jpyRate: Double?
    var brlRate: Double?
    
    func populateRates(rates: [String : Double]) {
        
        if let gbp = rates["GBP"] { gbpRate = gbp }
        
        if let eur = rates["EUR"] { eurRate = eur }
        
        if let jpy = rates["JPY"] { jpyRate = jpy }
        
        if let brl = rates["BRL"] { brlRate = brl }
        
    }
    
    func getConvertedAmount(country: Country) -> Double? {
        
        guard let amount = inputAmount else { return nil }
        
        switch country {
            
        case .us:
            return amount.roundToNearestValue(value: 0.01)
        case .uk:
            if let gbp = gbpRate {
                return (amount * gbp).roundToNearestValue(value: 0.01)
            } else {
                return nil
            }
        case .eu:
            if let eur = eurRate {
                return (amount * eur).roundToNearestValue(value: 0.01)
            } else {
                return nil
            }
        case .jp:
            if let jpy = jpyRate {
                return (amount * jpy).roundToNearestValue(value: 0.01)
            } else {
                return nil
            }
        case .br:
            if let brl = brlRate {
                return (amount * brl).roundToNearestValue(value: 0.01)
            } else {
                return nil
            }
    
        }
    }
    
}
