//
//  DataSourceTest.swift
//  CarsSearch
//
//  Created by Yahia Work on 6/13/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import XCTest

@testable import CarsSearch

class DataSourceTest: XCTestCase {
    
    
    func testOnlineDataSourceCount() {
        DataAccessController.sharedInstance.setNewDataSource(source: .Online)
        let exepetion:XCTestExpectation = self.expectation(description: "waitTillConnectionDone")
        
        DataAccessController.sharedInstance.getCars(withFilter: .All) { (items, errorMessage) in
            XCTAssert(items.count == 90 , "Count is wrong")
            exepetion.fulfill()
        }
        self.wait(for: [exepetion], timeout: 5)
    }
    
    
    
}
