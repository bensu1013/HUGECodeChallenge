//
//  CurrencyAPI.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation

struct CurrencyAPI {
    
    //MARK: - Url of the api call for currency exchange rates for USD
    private static var urlString = "http://api.fixer.io/latest?base=USD"
    
    //MARK: - Method to call on api and give back a dictionary through closure
    static func getExchangeRates(handler: @escaping ([String : Any]) -> () ) {
        guard let uUrl = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: uUrl) { (data, response, error) in
            
            if error == nil {
                guard let uData = data else { return }
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: uData, options: [])
            
                    guard let returnData = json as? [String : Any] else { return }
                    
                    handler(returnData)
                    
                } catch {
                    
                }
            }
            
            }.resume()
        
    }
    
}
