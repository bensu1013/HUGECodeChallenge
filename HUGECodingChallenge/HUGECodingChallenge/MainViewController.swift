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
    
    var dataModel = DataModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false

        self.tableView.backgroundView?.backgroundColor = UIColor.clear
        
    }
    
    @IBAction func convertButtonAction(_ sender: UIButton) {
        
        self.textField.resignFirstResponder()
        
        guard let input = textField.text else { return }
        
        if input != "" {
            
            if let amount = Double(input) {
                
                dataModel.inputAmount = amount.roundToNearestValue(value: 0.01)
                
                CurrencyAPI.getExchangeRates(handler: { (data) in

                    self.dataModel.populateRates(rates: data)
                    
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
            
            if let amount = dataModel.getConvertedAmount(country: .br) { cell.detailTextLabel?.text = "$R \(amount)" }
            else { cell.detailTextLabel?.text = "" }
            
        default:
            
            break
            
        }
        
    }
    
}
