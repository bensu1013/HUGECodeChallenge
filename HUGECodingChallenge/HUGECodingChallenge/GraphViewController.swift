//
//  GraphViewController.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var brlLabel: UILabel!
    
    @IBOutlet weak var zeroAmountLabel: UILabel!
    @IBOutlet weak var lowAmountLabel: UILabel!
    @IBOutlet weak var midAmountLabel: UILabel!
    @IBOutlet weak var highAmountLabel: UILabel!
    
    @IBOutlet weak var graphView: UIView!
    
    var exchangeRates = [String : Double]()
    var exchangeAmounts = [String : Double]()
    var inputAmount: Double = 0
    var highestExchange: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.exchangeAmounts = populateExchangeAmounts(rates: exchangeRates)
        self.placeExchangeLabels()
        self.calculateForGraphLabels()
        
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    func populateExchangeAmounts(rates: [String : Double]) -> [String : Double] {
        
        var returnData = [String : Double]()
        
        if let gbp = rates["GBP"] {

            returnData["GBP"] = convertAmount(rate: gbp)
            
        }
        
        if let eur = rates["EUR"] {
            
            returnData["EUR"] = convertAmount(rate: eur)
            
        }
        
        if let jpy = rates["JPY"] {
            
            returnData["JPY"] = convertAmount(rate: jpy)
            
        }
        
        if let brl = rates["BRL"] {
            
            returnData["BRL"] = convertAmount(rate: brl)
            
        }
    
        return returnData
        
    }
    
    func convertAmount(rate: Double) -> Double {
        
        let converted = changeDoubleToMoney(amount: rate * inputAmount)
        
        highestExchange = converted > highestExchange ? converted : highestExchange
        
        return converted
        
    }
    
    func changeDoubleToMoney(amount: Double) -> Double {
        
        return Double(round(amount * 100) / 100)
        
    }
    
    func calculateForGraphLabels() {
        
        highAmountLabel.text = "\(highestExchange)"
        midAmountLabel.text = "\(changeDoubleToMoney(amount: highestExchange * 0.45))"
        lowAmountLabel.text = "\(changeDoubleToMoney(amount: highestExchange * 0.30))"
        zeroAmountLabel.text = "\(changeDoubleToMoney(amount: highestExchange * 0.15))"
        
    }
    
    func placeExchangeLabels() {
        
        usdLabel.text = "\(inputAmount)"
        gbpLabel.text = "\(exchangeAmounts["GBP"]!)"
        eurLabel.text = "\(exchangeAmounts["EUR"]!)"
        jpyLabel.text = "\(exchangeAmounts["JPY"]!)"
        brlLabel.text = "\(exchangeAmounts["BRL"]!)"
        
    }

}















