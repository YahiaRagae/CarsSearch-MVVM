//
//  LoadFavorites+CarListViewModel.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation

extension CarListViewModel {
    func loadCarsFromFavorites( ){
        self.orginalItems = DataAccessController.sharedInstance.getFavorite(withFilter: filter)
        self.items = self.getSortedList()
    }
    
}
