//
//  CurrencyAPI.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation

struct CurrencyAPI {
    
    //Url of the api call for currency exchange rates for USD
    private static var urlString = "http://api.fixer.io/latest?base=USD"
    
    //Method to sort and structure json to appropriate data
    private static func structureAPIData(data: [String : Any]) -> [String : Double] {
        
        var returnData: [String : Double] = [:]
        
        if let rates = data["rates"] as? [String : Double] {
            
            if let gbp = rates["GBP"] { returnData["GBP"] = gbp }
            
            if let eur = rates["EUR"] { returnData["EUR"] = eur }
            
            if let jpy = rates["JPY"] { returnData["JPY"] = jpy }
            
            if let brl = rates["BRL"] { returnData["BRL"] = brl }
        }
        
        return returnData
        
    }
    
    //Method to call on api and give back a dictionary through closure
    static func getExchangeRates(handler: @escaping ([String : Double]) -> () ) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                guard let data = data else { return }
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
            
                    guard let returnData = json as? [String : Any] else { return }
                    
                    handler(structureAPIData(data: returnData))
                    
                } catch {
                    
                }
            }
            
            }.resume()
        
    }
    
}
