//
//  ViewController.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var exchangeRates: [String : Double] = [:]
    
    var inputAmount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false

        self.tableView.backgroundView?.backgroundColor = UIColor.clear
        
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
                    
                    DispatchQueue.main.async { self.tableView.reloadData() }
                    
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
        
        self.exchangeRates.removeAll()
        
        self.tableView.reloadData()
        
    }
    
    @IBAction func showGraphButtonAction(_ sender: UIButton) {
                
        self.performSegue(withIdentifier: "graphViewSegue", sender: nil)
        
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
            
            if let gbp = rates["GBP"] { returnData["GBP"] = gbp }
            
            if let eur = rates["EUR"] { returnData["EUR"] = eur }
            
            if let jpy = rates["JPY"] { returnData["JPY"] = jpy }
            
            if let brl = rates["BRL"] { returnData["BRL"] = brl }
        }
        
        return returnData
        
    }
    
}

//MARK: - TableView Delegate Methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.tableView.bounds.height / 4
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "exchangeCell", for: indexPath)
        
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.darkGray.cgColor
        
        displayContentFor(cell: &cell, index: indexPath.row)
        
        return cell
        
    }
    
    func displayContentFor(cell: inout UITableViewCell, index: Int) {
        
        switch index {
            
        case 0:
            
            cell.textLabel?.text = "GBP"
            
            if let rate = exchangeRates["GBP"] { cell.detailTextLabel?.text = "£ \(inputAmount * rate)" }
            else { cell.detailTextLabel?.text = "" }
            
        case 1:
            
            cell.textLabel?.text = "EUR"
            if let rate = exchangeRates["EUR"] { cell.detailTextLabel?.text = "€ \(inputAmount * rate)" }
            else { cell.detailTextLabel?.text = "" }
            
        case 2:
            
            cell.textLabel?.text = "JPY"
            if let rate = exchangeRates["JPY"] { cell.detailTextLabel?.text = "￥ \(inputAmount * rate)" }
            else { cell.detailTextLabel?.text = "" }
            
        case 3:
            
            cell.textLabel?.text = "BRL"
            if let rate = exchangeRates["BRL"] { cell.detailTextLabel?.text = "R$ \(inputAmount * rate)" }
            else { cell.detailTextLabel?.text = "" }
            
        default:
            
            break
            
        }
        
    }
    
    
    
    
}





