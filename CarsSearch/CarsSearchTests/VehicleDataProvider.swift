//
//  VehicleDataProvider.swift
//  CarsSearch
//
//  Created by Yahia Work on 6/13/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import SwiftyJSON
@testable import CarsSearch


class VehicleDataProvider:NSObject{
    
    static let strObject = "{\"ID\":1,\"FirstRegistration\":\"7/2013\",\"AccidentFree\":true,\"Images\":[\"http://sumamo.de/iOS-TechChallange/assets/bmw/01.jpg\",\"http://sumamo.de/iOS-TechChallange/assets/bmw/02.jpg\",\"http://sumamo.de/iOS-TechChallange/assets/bmw/03.jpg\",\"http://sumamo.de/iOS-TechChallange/assets/bmw/04.jpg\"],\"PowerKW\":335,\"Address\":\"50667 KÃ¶ln\",\"Price\":4659,\"Mileage\":31944,\"Make\":\"BMW\",\"FuelType\":\"Diesel\"}"
    static func getVehicle()->Vehicle{
        
        let json:JSON = JSON(parseJSON: strObject)
        let vehicle:Vehicle = Vehicle(json: json);

        return vehicle;
        
    }
    
}
