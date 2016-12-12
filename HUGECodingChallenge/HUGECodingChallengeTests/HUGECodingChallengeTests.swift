//
//  HUGECodingChallengeTests.swift
//  HUGECodingChallengeTests
//
//  Created by Benjamin Su on 12/12/16.
//  Copyright © 2016 Benjamin Su. All rights reserved.
//

import XCTest
@testable import HUGECodingChallenge

class HUGECodingChallengeTests: XCTestCase {
    
    let shared = DataModel.shared
    
    let fakeData = [ "GBP" : 0.8,
                     "JPY" : 114.6,
                     "BRL" : 3.5,
                     "EUR" : 0.97,]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadDataModel() {
        
        shared.populateRates(rates: fakeData)
        
        if let gbp = shared.gbpRate {
            XCTAssert(gbp == 0.8, "That is correct")
            
            print("well well well")
            
        }
        
        
        
    }
    
}
