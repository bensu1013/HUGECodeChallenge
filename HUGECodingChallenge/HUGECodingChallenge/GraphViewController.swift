//
//  GraphViewController.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/7/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class GraphViewController: UIViewController {
    
    @IBOutlet weak var maxAmountLabel: UILabel!
    @IBOutlet weak var highAmountLabel: UILabel!
    @IBOutlet weak var dAmountLabel: UILabel!
    @IBOutlet weak var cAmountLabel: UILabel!
    @IBOutlet weak var bAmountLabel: UILabel!
    @IBOutlet weak var aAmountLabel: UILabel!
    @IBOutlet weak var lowAmountLabel: UILabel!
    @IBOutlet weak var minAmountLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    
    var dataModel = DataModel.shared
    
    let usdGraph = UIView()
    let gbpGraph = UIView()
    let eurGraph = UIView()
    let jpyGraph = UIView()
    let brlGraph = UIView()
    
    let graphSeperator = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //Setting text to a preset multiplier value.
    func calculateForGraphLabels() {
        
        guard let amount = dataModel.inputAmount else { return }
        
        maxAmountLabel.text = "\(120 * amount)"
        highAmountLabel.text = "\(110 * amount)"
        dAmountLabel.text = "\(100 * amount)"
        cAmountLabel.text = "\(4 * amount)"
        bAmountLabel.text = "\(3 * amount)"
        aAmountLabel.text = "\(2 * amount)"
        lowAmountLabel.text = "\(1 * amount)"
        minAmountLabel.text = "\(0)"
        
    }
    
}

//MARK: - Programmatic subview setup
extension GraphViewController {
    
    func setupGraphSubviews() {
        
        addGraphSubviews()
        positionSubviews()
        
    }

    //Adding objects to the subview in addition to any settings required for the objects
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
    
    //Creating preset bar frames to have a height of 0 so they are not visible to the user.
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
    
    //Main graph animation. Animates bars up to their respective exchange rates
    func animateGraphView() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.usdGraph.frame = CGRect(x: self.graphView.bounds.width * 0.03,
                                         y: self.getBarYStart(country: .us),
                                         width: self.graphView.bounds.width * 0.17,
                                         height: self.getBarHeight(country: .us))
            
            self.gbpGraph.frame = CGRect(x: self.graphView.bounds.width * 0.22,
                                         y: self.getBarYStart(country: .uk),
                                         width: self.graphView.bounds.width * 0.17,
                                         height: self.getBarHeight(country: .uk))
            
            self.eurGraph.frame = CGRect(x: self.graphView.bounds.width * 0.41,
                                         y: self.getBarYStart(country: .eu),
                                         width: self.graphView.bounds.width * 0.17,
                                         height: self.getBarHeight(country: .eu))
            
            self.jpyGraph.frame = CGRect(x: self.graphView.bounds.width * 0.60,
                                         y: self.getBarYStart(country: .jp),
                                         width: self.graphView.bounds.width * 0.17,
                                         height: self.getBarHeight(country: .jp))
            
            self.brlGraph.frame = CGRect(x: self.graphView.bounds.width * 0.79,
                                         y: self.getBarYStart(country: .br),
                                         width: self.graphView.bounds.width * 0.17,
                                         height: self.getBarHeight(country: .br))
            
        })
        
    }
    
    //Method used to get the starting Y point of the bar in graph for animation purposes.
    func getBarYStart(country: Country) -> CGFloat {
        
        let height = self.graphView.bounds.height
        
        switch country {
            
        case .us:
            
            return height - self.getBarHeight(country: country)
            
        case .uk:
            
            return height - self.getBarHeight(country: country)
            
        case .eu:
            
            return height - self.getBarHeight(country: country)
            
        case .jp:
            
            return height - self.getBarHeight(country: country)
            
        case .br:
            
            return height - self.getBarHeight(country: country)
            
        }
        
    }
    
    //Method used to get the height of a bar in graph for animation purposes. Dividing by seven because of how the graphview is set up with its labels
    func getBarHeight(country: Country) -> CGFloat {
        
        let height = self.graphView.bounds.height
        
        switch country {
            
        case .us:
            
            return (height / 7)
            
        case .uk:
            
            if let rate = dataModel.gbpRate { return (height / 7 * CGFloat(rate)) }
            
        case .eu:
            
            if let rate = dataModel.eurRate { return (height / 7 * CGFloat(rate)) }
            
        case .jp:
            
            if let rate = dataModel.jpyRate { return (height / 7 * 5) + (height / 7 * CGFloat(rate - 100) / 10) }
            
        case .br:
            
            if let rate = dataModel.brlRate { return (height / 7 * CGFloat(rate)) }
            
        }
        
        return 0.0
        
    }
    
}
