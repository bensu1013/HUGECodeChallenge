//
//  GraphView.swift
//  HUGECodingChallenge
//
//  Created by Benjamin Su on 12/12/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class GraphView: UIView {
    
    var firstBar = UIView()
    var secondBar = UIView()
    var thirdBar = UIView()
    var fourthBar = UIView()
    var fifthBar = UIView()
    
    var seperatorBar = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setting subviews of graph to positions, size and color
extension GraphView {
    
    func setupSubviews() {
        
        self.addSubview(firstBar)
        firstBar.frame = CGRect(x: self.bounds.width * 0.03, y: self.bounds.height, width: self.bounds.width * 0.17, height: 0.0)
        firstBar.backgroundColor = UIColor.generateRandomColor()
        
        self.addSubview(secondBar)
        secondBar.frame = CGRect(x: self.bounds.width * 0.22, y: self.bounds.height, width: self.bounds.width * 0.17, height: 0.0)
        secondBar.backgroundColor = UIColor.generateRandomColor()
        
        self.addSubview(thirdBar)
        thirdBar.frame = CGRect(x: self.bounds.width * 0.41, y: self.bounds.height, width: self.bounds.width * 0.17, height: 0.0)
        thirdBar.backgroundColor = UIColor.generateRandomColor()
        
        
        self.addSubview(fourthBar)
        fourthBar.frame = CGRect(x: self.bounds.width * 0.60, y: self.bounds.height, width: self.bounds.width * 0.17, height: 0.0)
        fourthBar.backgroundColor = UIColor.generateRandomColor()
        
        self.addSubview(fifthBar)
        fifthBar.frame = CGRect(x: self.bounds.width * 0.79, y: self.bounds.height, width: self.bounds.width * 0.17, height: 0.0)
        fifthBar.backgroundColor = UIColor.generateRandomColor()
        
        self.addSubview(seperatorBar)
        seperatorBar.frame = CGRect(x: 0, y: self.bounds.height / 7 * 2, width: self.bounds.width, height: 2)
        seperatorBar.backgroundColor = UIColor.darkGray
        
    }
    
}

//MARK: - Animation methods
extension GraphView {
    
    //Method used to get the starting Y point of the bar in graph for animation purposes.
    private func getBarYStart(country: Country) -> CGFloat {
        
        let height = self.bounds.height
        
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
    private func getBarHeight(country: Country) -> CGFloat {
        
        let height = self.bounds.height
        
        switch country {
            
        case .us:
            
            if let _ = DataModel.shared.inputAmount { return (height / 7) }
            
        case .uk:
            
            if let rate = DataModel.shared.gbpRate { return (height / 7 * CGFloat(rate)) }
            
        case .eu:
            
            if let rate = DataModel.shared.eurRate { return (height / 7 * CGFloat(rate)) }
            
        case .jp:
            
            if let rate = DataModel.shared.jpyRate { return (height / 7 * 5) + (height / 7 * CGFloat(rate - 100) / 10) }
            
        case .br:
            
            if let rate = DataModel.shared.brlRate { return (height / 7 * CGFloat(rate)) }
            
        }
        
        return 0.0
        
    }
    
    //Main graph animation. Animates bars up to their respective exchange rates
    func animateGraphView() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.firstBar.frame = CGRect(x: self.bounds.width * 0.03,
                                         y: self.getBarYStart(country: .us),
                                         width: self.bounds.width * 0.17,
                                         height: self.getBarHeight(country: .us))
            
            self.secondBar.frame = CGRect(x: self.bounds.width * 0.22,
                                          y: self.getBarYStart(country: .uk),
                                          width: self.bounds.width * 0.17,
                                          height: self.getBarHeight(country: .uk))
            
            self.thirdBar.frame = CGRect(x: self.bounds.width * 0.41,
                                         y: self.getBarYStart(country: .eu),
                                         width: self.bounds.width * 0.17,
                                         height: self.getBarHeight(country: .eu))
            
            self.fourthBar.frame = CGRect(x: self.bounds.width * 0.60,
                                          y: self.getBarYStart(country: .jp),
                                          width: self.bounds.width * 0.17,
                                          height: self.getBarHeight(country: .jp))
            
            self.fifthBar.frame = CGRect(x: self.bounds.width * 0.79,
                                         y: self.getBarYStart(country: .br),
                                         width: self.bounds.width * 0.17,
                                         height: self.getBarHeight(country: .br))
            
        })
        
    }
    
}
