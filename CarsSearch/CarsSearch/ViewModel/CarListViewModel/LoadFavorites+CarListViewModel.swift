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
    
    func processFavoritesAt(index  : Int){
        let vehicle : Vehicle = getVehiclefor(index: index)
        DataAccessController.sharedInstance.processFavorites(vehicle: vehicle)
    }
    func sendLocalNotificationFor(status:Bool , and index:Int){
        let vehicle : Vehicle = getVehiclefor(index: index)
        if(status)
        {
            NotificationCenter.default.post(name: RootTabViewModel.NOTIFICATION_ID_ADD_FAVORITES , object: vehicle)
        }else{
            NotificationCenter.default.post(name: RootTabViewModel.NOTIFICATION_ID_REMOVE_FAVORITES , object: vehicle)
        }
    }
}
