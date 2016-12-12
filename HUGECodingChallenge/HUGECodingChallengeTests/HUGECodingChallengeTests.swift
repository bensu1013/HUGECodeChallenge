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
    
    var viewModel = MainViewControllerModel()
    
    let fakeData = [ "GBP" : 0.8,
                     "JPY" : 114.6,
                     "BRL" : 3.5,
                     "EUR" : 0.97,]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewModel.dataModel.populateRates(data: fakeData)
        viewModel.dataModel.inputAmount = 10
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Test for loading data with a dictionary
    func testLoadDataModel() {
        
        if let gbp = viewModel.dataModel.gbpRate {
            
            XCTAssert(gbp == 0.8, "Storing of data from API call to datamodel is correct")
            
        }
    }
    
    //MARK: - Testing for conversion with input from user
    func testConvertActionNoInput() {
        
        viewModel.convertInfo(input: "") { (controller) in
            
            XCTAssert(controller != nil, "Alert is returned if no input was read")
            
        }
        
    }
    
    func testConvertActionWrongInput() {
        
        viewModel.convertInfo(input: "401daf258") { (controller) in
            
            XCTAssert(controller != nil, "Alert is returned if input included letters or symbols")
            
        }
        
    }
    
    func testConvertActionCorrectInput() {
        
        viewModel.convertInfo(input: "41258") { (controller) in
            
            XCTAssert(controller == nil, "Nil is returned in the event of proper user input")
            
        }
        
    }
    
    //MARK: - Testing for proper text input for tableview cells
    func testPopulateCell() {
    
        var cell = UITableViewCell()

        viewModel.displayContentFor(cell: &cell, index: 0)
        
        XCTAssert(cell.textLabel?.text == "GBP", "Title was set to the proper country")
        
    }
    
}









