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

    var viewModel = MainViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
        self.tableView.backgroundView?.backgroundColor = UIColor.clear
        
    }
    
    //Checks for input from user in textfield and returns with appropriate alerts if certain requirements aren't met.
    @IBAction func convertButtonAction(_ sender: UIButton) {
        
        self.textField.resignFirstResponder()
        
        guard let input = textField.text else { return }
        
        viewModel.convertInfo(input: input) { (controller) in
            
            if controller != nil {
                
                self.present(controller!, animated: true, completion: nil)
                
            } else {
                
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            }
            
        }
        
    }

    @IBAction func clearButtonAction(_ sender: UIButton) {
        
        self.textField.text = ""
        
        self.tableView.reloadData()
        
    }
    
    @IBAction func showGraphButtonAction(_ sender: UIButton) {
                
        self.performSegue(withIdentifier: "graphViewSegue", sender: nil)
        
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
        
        viewModel.displayContentFor(cell: &cell, index: indexPath.row)
        
        return cell
        
    }
    
}
