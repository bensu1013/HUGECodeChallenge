//
//  ViewController.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var exchangeRates: [String : Double] = [:]
    
    var inputAmount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(red: 40/255, green: 60/255, blue: 200/255, alpha: 1.0)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let dest = segue.destination as? GraphViewController {
            
            dest.exchangeRates = self.exchangeRates
            
            dest.inputAmount = self.inputAmount
            
        }
        
    }
    
    @IBAction func convertButtonAction(_ sender: UIButton) {
        
        self.textField.resignFirstResponder()
        
        guard let input = textField.text else { return }
        
        if input != "" {
            
            if let amount = Double(input) {
                
                inputAmount = amount
                
                CurrencyAPI.getExchangeRates(handler: { (data) in

                    self.exchangeRates = self.structureAPIData(data: data)
                    
                    self.textField.text = ""
                    
                    DispatchQueue.main.async {
                        
                        self.performSegue(withIdentifier: "graphViewSegue", sender: nil)
                        
                    }
                    
                })
                
            } else {
                
                self.present(createAlert(withTitle: "Woops", andMsg: "Numbers only please.\nThat means the commas too!"), animated: true, completion: nil)
                
            }
            
        } else {
            
            self.present(createAlert(withTitle: "Missing Amount", andMsg: "Can't convert thin air"), animated: true, completion: nil)
            
        }
    }

    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        
        self.textField.text = ""
        
    }
    
    func createAlert(withTitle: String, andMsg: String) -> UIAlertController {
        
        let alert = UIAlertController(title: withTitle, message: andMsg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        return alert
        
    }
    
    func structureAPIData(data: [String : Any]) -> [String : Double] {
        
        var returnData: [String : Double] = [:]
        
        if let rates = data["rates"] as? [String : Double] {
            
            if let gbp = rates["GBP"] {
                
                returnData["GBP"] = gbp
                
            }
            
            if let eur = rates["EUR"] {
                
                returnData["EUR"] = eur
                
            }
            
            if let jpy = rates["JPY"] {
                
                returnData["JPY"] = jpy
                
            }
            
            if let brl = rates["BRL"] {
                
                returnData["BRL"] = brl
                
            }
        }
        
        return returnData
        
    }
    
}





