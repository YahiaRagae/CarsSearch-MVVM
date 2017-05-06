//
//  CarsDataFetcher.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class CarsDataFetcher: BaseDataFetcher {
   

    let URL_GET_ALL_CARS : String = "URL_GET_ALL_CARS"
    
    // MARK: Getters
    func getCars(withFilter filter: Filter, completion: ((NSMutableArray, String?) -> Void)?) {
        let link = "\(getMainLink())make=\(filter.rawValue).json"
        
        getRequestWithJsonReponse(withLink: link) { (response, status) in
            var   items:NSMutableArray = NSMutableArray()
            if(status){
                items = self.parseVehicles(response: response)
            }
            completion?(items,response.result.error?.localizedDescription)
        }
    }
    
    
    // MARK: Parsers
    func parseVehicles(response: DataResponse<Any>) -> NSMutableArray{
        let items:NSMutableArray = NSMutableArray();
        let json = JSON(response.result.value!)
        if let itemsArray = json["vehicles"].array {
            for item in itemsArray {
                let vehicle:Vehicle = Vehicle.init(json: item)
                items.add(vehicle)
            }
        }
        return items;
    }
    
}


