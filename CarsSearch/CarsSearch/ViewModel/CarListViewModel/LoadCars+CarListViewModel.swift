//
//  LoadCars+CarListViewModel.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
extension CarListViewModel {
    func loadCarsFromInternet(completion: (( String?) -> Void)?){

        DataAccessController.sharedInstance.getCars(withFilter: self.filter) { (_items, errorMessage) in
            if(errorMessage != nil && _items.count == 0 ){
                completion!(errorMessage)
                return;
            }
            self.orginalItems = _items.mutableCopy()   as! NSMutableArray
            self.items = self.getSortedList()
            
            completion!(nil)
        }
    }
}
