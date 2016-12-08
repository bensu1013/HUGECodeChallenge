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
    
    @IBOutlet weak var maxAmountLabel: UILabel!
    @IBOutlet weak var highAmountLabel: UILabel!
    @IBOutlet weak var dAmountLabel: UILabel!
    @IBOutlet weak var cAmountLabel: UILabel!
    @IBOutlet weak var bAmountLabel: UILabel!
    @IBOutlet weak var aAmountLabel: UILabel!
    @IBOutlet weak var lowAmountLabel: UILabel!
    @IBOutlet weak var minAmountLabel: UILabel!
    
    @IBOutlet weak var graphView: UIView!
    
    let usdGraph = UIView()
    let gbpGraph = UIView()
    let eurGraph = UIView()
    let jpyGraph = UIView()
    let brlGraph = UIView()
    
    let graphSeperator = UIView()
    
    var exchangeRates = [String : Double]()
    var exchangeAmounts = [String : Double]()
    var inputAmount: Double = 0
    var highestExchange: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exchangeAmounts = populateExchangeAmounts(rates: exchangeRates)
        self.fillTextOfExchangeLabels()
        self.calculateForGraphLabels()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupGraphSubviews()
        self.animateGraphView()

    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
        
    }

    
}

//MARK: - ViewDidLoad Setup Methods
extension GraphViewController {
    
    func populateExchangeAmounts(rates: [String : Double]) -> [String : Double] {
        
        var returnData = [String : Double]()
        
        if let gbp = rates["GBP"] { returnData["GBP"] = convertAmount(rate: gbp) }
        
        if let eur = rates["EUR"] { returnData["EUR"] = convertAmount(rate: eur) }
        
        if let jpy = rates["JPY"] { returnData["JPY"] = convertAmount(rate: jpy) }
        
        if let brl = rates["BRL"] { returnData["BRL"] = convertAmount(rate: brl) }
        
        return returnData
        
    }
    
    func convertAmount(rate: Double) -> Double {
        
        let converted = DataModel.changeDoubleToMoney(amount: rate * inputAmount)
        
        highestExchange = converted > highestExchange ? converted : highestExchange
        
        return converted
        
    }
    
    func calculateForGraphLabels() {
        
        maxAmountLabel.text = "\(120 * inputAmount)"
        highAmountLabel.text = "\(110 * inputAmount)"
        dAmountLabel.text = "\(100 * inputAmount)"
        cAmountLabel.text = "\(4 * inputAmount)"
        bAmountLabel.text = "\(3 * inputAmount)"
        aAmountLabel.text = "\(2 * inputAmount)"
        lowAmountLabel.text = "\(1 * inputAmount)"
        minAmountLabel.text = "\(0)"
        
    }
    
    func fillTextOfExchangeLabels() {
        
        usdLabel.text = "\(1.00)"
        
        if let text = exchangeRates["GBP"] { gbpLabel.text = "\(text)" }
        if let text = exchangeRates["EUR"] { eurLabel.text = "\(text)" }
        if let text = exchangeRates["JPY"] { jpyLabel.text = "\(text)" }
        if let text = exchangeRates["BRL"] { brlLabel.text = "\(text)" }
        
    }
    
}

//MARK: - Programmatic subview setup
extension GraphViewController {
    
    func setupGraphSubviews() {
        
        addGraphSubviews()
        positionSubviews()
        
    }

    func addGraphSubviews() {
        
        usdGraph.backgroundColor = UIColor.generateRandomColor()
        gbpGraph.backgroundColor = UIColor.generateRandomColor()
        eurGraph.backgroundColor = UIColor.generateRandomColor()
        jpyGraph.backgroundColor = UIColor.generateRandomColor()
        brlGraph.backgroundColor = UIColor.generateRandomColor()
        graphSeperator.backgroundColor = UIColor.darkGray
        graphView.addSubview(usdGraph)
        graphView.addSubview(gbpGraph)
        graphView.addSubview(eurGraph)
        graphView.addSubview(jpyGraph)
        graphView.addSubview(brlGraph)
        graphView.addSubview(graphSeperator)
        
    }
    
    func positionSubviews() {
        
        usdGraph.frame = CGRect(x: graphView.bounds.width * 0.03, y: graphView.bounds.height, width: graphView.bounds.width * 0.17, height: 0.0)
        gbpGraph.frame = CGRect(x: graphView.bounds.width * 0.22, y: graphView.bounds.height, width: graphView.bounds.width * 0.17, height: 0.0)
        eurGraph.frame = CGRect(x: graphView.bounds.width * 0.41, y: graphView.bounds.height, width: graphView.bounds.width * 0.17, height: 0.0)
        jpyGraph.frame = CGRect(x: graphView.bounds.width * 0.60, y: graphView.bounds.height, width: graphView.bounds.width * 0.17, height: 0.0)
        brlGraph.frame = CGRect(x: graphView.bounds.width * 0.79, y: graphView.bounds.height, width: graphView.bounds.width * 0.17, height: 0.0)
        graphSeperator.frame = CGRect(x: 0, y: graphView.bounds.height / 7 * 2, width: graphView.bounds.width, height: 2)
        
    }
    
}

//MARK: - Animation methods
extension GraphViewController {
    
    func animateGraphView() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.usdGraph.frame = CGRect(x: self.graphView.bounds.width * 0.03, y: self.graphView.bounds.height - self.getBarHeight(country: .us), width: self.graphView.bounds.width * 0.17, height: self.getBarHeight(country: .us))
            self.gbpGraph.frame = CGRect(x: self.graphView.bounds.width * 0.22, y: self.graphView.bounds.height - self.getBarHeight(country: .uk), width: self.graphView.bounds.width * 0.17, height: self.getBarHeight(country: .uk))
            self.eurGraph.frame = CGRect(x: self.graphView.bounds.width * 0.41, y: self.graphView.bounds.height - self.getBarHeight(country: .eu), width: self.graphView.bounds.width * 0.17, height: self.getBarHeight(country: .eu))
            self.jpyGraph.frame = CGRect(x: self.graphView.bounds.width * 0.60, y: self.graphView.bounds.height - self.getBarHeight(country: .jp), width: self.graphView.bounds.width * 0.17, height: self.getBarHeight(country: .jp))
            self.brlGraph.frame = CGRect(x: self.graphView.bounds.width * 0.79, y: self.graphView.bounds.height - self.getBarHeight(country: .br), width: self.graphView.bounds.width * 0.17, height: self.getBarHeight(country: .br))
            
        })
        
    }
    
    func getBarHeight(country: Country) -> CGFloat {
        
        let height = self.graphView.bounds.height
        
        switch country {
        case .us:
            return (height / 7)
        case .uk:
            if let rate = exchangeRates["GBP"] {
                return (height / 7 * CGFloat(rate))
            }
        case .eu:
            if let rate = exchangeRates["EUR"] {
                return (height / 7 * CGFloat(rate))
            }
        case .jp:
            if let rate = exchangeRates["JPY"] {
                return (height / 7 * 5) + (height / 7 * CGFloat(rate - 100) / 10)
            }
        case .br:
            if let rate = exchangeRates["BRL"] {
                return (height / 7 * CGFloat(rate))
            }
        }
        
        return 0.0
    }
    
}

enum Country {
    
    case us, uk, eu, jp, br
    
}









