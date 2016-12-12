//
//  GraphViewModel.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/12/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class GraphViewModel: UIView {
    
    let dataModel = DataModel.shared
    
    var aLabel = UILabel()
    var bLabel = UILabel()
    var cLabel = UILabel()
    var dLabel = UILabel()
    var eLabel = UILabel()
    var fLabel = UILabel()
    var gLabel = UILabel()
    var hLabel = UILabel()
    
    var firstNameLabel = UILabel()
    var secondNameLabel = UILabel()
    var thirdNameLabel = UILabel()
    var fourthNameLabel = UILabel()
    var fifthNameLabel = UILabel()
    
    var graphView: GraphView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        provideGraphLabels()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Methods used to fill labels with relevant data
extension GraphViewModel {
    
    fileprivate func provideGraphLabels() {
        
        guard let amount = dataModel.inputAmount else { return }
        
        aLabel.text = "\(120 * amount)"
        bLabel.text = "\(110 * amount)"
        cLabel.text = "\(100 * amount)"
        dLabel.text = "\(4 * amount)"
        eLabel.text = "\(3 * amount)"
        fLabel.text = "\(2 * amount)"
        gLabel.text = "\(1 * amount)"
        hLabel.text = "\(0)"
        
    }
    
}

//MARK: - Setting positions and size of subviews
extension GraphViewModel {
    
    fileprivate func setupSubviews() {
        
        prepareNameLabelSubviews()
        prepareGraphLabelSubviews()
        prepareGraphViewSubview()
        
    }
    
    private func prepareNameLabelSubviews() {
        
        self.addSubview(firstNameLabel)
        firstNameLabel.frame = CGRect(x: self.bounds.width * 0.2, y: self.bounds.height * 0.85,
                                      width: self.bounds.width * 0.16, height: self.bounds.height * 0.15)
        firstNameLabel.textAlignment = .center
        firstNameLabel.text = "USD"
        
        
        self.addSubview(secondNameLabel)
        secondNameLabel.frame = CGRect(x: self.bounds.width * 0.36, y: self.bounds.height * 0.85,
                                       width: self.bounds.width * 0.16, height: self.bounds.height * 0.15)
        secondNameLabel.textAlignment = .center
        secondNameLabel.text = "GBP"
        
        self.addSubview(thirdNameLabel)
        thirdNameLabel.frame = CGRect(x: self.bounds.width * 0.52, y: self.bounds.height * 0.85,
                                      width: self.bounds.width * 0.16, height: self.bounds.height * 0.15)
        thirdNameLabel.textAlignment = .center
        thirdNameLabel.text = "EUR"
        
        self.addSubview(fourthNameLabel)
        fourthNameLabel.frame = CGRect(x: self.bounds.width * 0.68, y: self.bounds.height * 0.85,
                                       width: self.bounds.width * 0.16, height: self.bounds.height * 0.15)
        fourthNameLabel.textAlignment = .center
        fourthNameLabel.text = "JPY"
        
        self.addSubview(fifthNameLabel)
        fifthNameLabel.frame = CGRect(x: self.bounds.width * 0.84, y: self.bounds.height * 0.85,
                                      width: self.bounds.width * 0.16, height: self.bounds.height * 0.15)
        fifthNameLabel.textAlignment = .center
        fifthNameLabel.text = "BRL"
        
    }
    
    private func prepareGraphLabelSubviews() {
        
        self.addSubview(aLabel)
        aLabel.frame = CGRect(x: 0, y: 0,
                              width: self.bounds.width * 0.2, height: self.bounds.height * 0.113)
        aLabel.textAlignment = .right
        
        self.addSubview(bLabel)
        bLabel.frame = CGRect(x: 0, y: self.bounds.height * 0.113,
                              width: self.bounds.width * 0.2, height: self.bounds.height * 0.113)
        bLabel.textAlignment = .right
        
        self.addSubview(cLabel)
        cLabel.frame = CGRect(x: 0, y: self.bounds.height * 0.226,
                              width: self.bounds.width * 0.2, height: self.bounds.height * 0.113)
        cLabel.textAlignment = .right
        
        self.addSubview(dLabel)
        dLabel.frame = CGRect(x: 0, y: self.bounds.height * 0.339,
                              width: self.bounds.width * 0.2, height: self.bounds.height * 0.113)
        dLabel.textAlignment = .right
        
        self.addSubview(eLabel)
        eLabel.frame = CGRect(x: 0, y: self.bounds.height * 0.452,
                              width: self.bounds.width * 0.2, height: self.bounds.height * 0.113)
        eLabel.textAlignment = .right
        
        self.addSubview(fLabel)
        fLabel.frame = CGRect(x: 0, y: self.bounds.height * 0.565,
                              width: self.bounds.width * 0.2, height: self.bounds.height * 0.113)
        fLabel.textAlignment = .right
        
        self.addSubview(gLabel)
        gLabel.frame = CGRect(x: 0, y: self.bounds.height * 0.678,
                              width: self.bounds.width * 0.2, height: self.bounds.height * 0.113)
        gLabel.textAlignment = .right
        
        self.addSubview(hLabel)
        hLabel.frame = CGRect(x: 0, y: self.bounds.height * 0.791,
                              width: self.bounds.width * 0.2, height: self.bounds.height * 0.113)
        hLabel.textAlignment = .right
        
    }
    
    private func prepareGraphViewSubview() {
        
        graphView = GraphView(frame: CGRect(x: self.bounds.width * 0.2, y: self.bounds.height * 0.05,
                                            width: self.bounds.width * 0.8, height: self.bounds.height * 0.8))
        self.addSubview(graphView)
        
    }
    
}
