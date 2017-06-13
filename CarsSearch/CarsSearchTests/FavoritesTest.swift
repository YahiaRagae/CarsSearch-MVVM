//
//  FavoritesTest.swift
//  CarsSearch
//
//  Created by Yahia Work on 6/13/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import XCTest

@testable import CarsSearch

class FavoritesTest: XCTestCase {
    let dataAccessController:DataAccessController = DataAccessController.sharedInstance;
    let vehicle = VehicleDataProvider.getVehicle()
    
    override func setUp() {
        super.setUp()
        
        //Clear Favorites
        let favorites:[Vehicle]  = dataAccessController.getFavorite(withFilter: .All) as! [Vehicle]
        for vehicle in favorites{
            dataAccessController.processFavorites(vehicle: vehicle)

        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddVehicleToFavorites() {
        dataAccessController.processFavorites(vehicle: vehicle)
        let favoeitesCount:Int = dataAccessController.getFavorite(withFilter: .All).count
        XCTAssert(favoeitesCount == 1 , "Favorites Add Problem ")
        
    }
    
    func testRemoveVehicleToFavorites() {
        dataAccessController.processFavorites(vehicle: vehicle)
        dataAccessController.processFavorites(vehicle: vehicle)
        let favoeitesCount:Int = dataAccessController.getFavorite(withFilter: .All).count
        XCTAssert(favoeitesCount == 0 , "Favorites Remove Problem ")
    }
    
    func testCheckIfVehicleExistInFavorites() {
        dataAccessController.processFavorites(vehicle: vehicle)
        
        let favoeiteStatus:Bool = dataAccessController.checkFavorite(vehicle: vehicle)
        XCTAssert(favoeiteStatus  , "Favorites checkFavorite Problem ")
    }

    
    
   
    
    
    
}
