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
    
    var graphViewModel: GraphViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphViewModel = GraphViewModel.init(frame: CGRect(x: 0.0, y: self.view.bounds.height * 0.2, width: self.view.bounds.width, height: self.view.bounds.height * 0.55))
        self.view.addSubview(graphViewModel)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        graphViewModel.graphView.animateGraphView()
        
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
        
    }

    
}
