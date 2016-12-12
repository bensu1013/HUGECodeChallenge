//
//  MainViewControllerModel.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/12/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

struct MainViewControllerModel {
    
    let dataModel = DataModel.shared
    
    //Creates and returns a alertcontroller with preset action of type cancel
    private func createAlert(withTitle: String, andMsg: String) -> UIAlertController {
        
        let alert = UIAlertController(title: withTitle, message: andMsg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        return alert
        
    }
    
    //Does the logic of checking input and calling API, returning an alert if errors occur
    func convertInfo(input: String, handler: @escaping (UIAlertController?) -> () ) {
        
        if input != "" {
            
            if let amount = Double(input) {
                
                dataModel.inputAmount = amount
                
                self.dataModel.getRatesFromApi {
                    
                    handler(nil)
                    
                }
                
            } else {
                
                handler(createAlert(withTitle: "Woops", andMsg: "Numbers only please.\nThat means the commas too!"))
                
            }
            
        } else {
            
            handler(createAlert(withTitle: "Missing Amount", andMsg: "Can't convert thin air"))
            
        }
        
    }

    //Method used to populate cell text
    func displayContentFor(cell: inout UITableViewCell, index: Int) {
        
        switch index {
            
        case 0:
            
            cell.textLabel?.text = "GBP"
            
            if let amount = dataModel.getConvertedAmount(country: .uk) { cell.detailTextLabel?.text = "£ \(amount)" }
            else { cell.detailTextLabel?.text = "" }
            
        case 1:
            
            cell.textLabel?.text = "EUR"
            
            if let amount = dataModel.getConvertedAmount(country: .eu) { cell.detailTextLabel?.text = "€ \(amount)" }
            else { cell.detailTextLabel?.text = "" }
            
        case 2:
            
            cell.textLabel?.text = "JPY"
            
            if let amount = dataModel.getConvertedAmount(country: .jp) { cell.detailTextLabel?.text = "￥ \(amount)" }
            else { cell.detailTextLabel?.text = "" }
            
        case 3:
            
            cell.textLabel?.text = "BRL"
            
            if let amount = dataModel.getConvertedAmount(country: .br) { cell.detailTextLabel?.text = "R$ \(amount)" }
            else { cell.detailTextLabel?.text = "" }
            
        default:
            
            break
            
        }
        
    }
    
}
