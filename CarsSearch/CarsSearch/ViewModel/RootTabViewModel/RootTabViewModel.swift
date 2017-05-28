//
//  RootTabViewModel.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import RxSwift


class RootTabViewModel : NSObject,RootTabViewModelProtocol{
    
    static let NOTIFICATION_ID_ADD_FAVORITES = NSNotification.Name(rawValue: "NOTIFICATION_ID_ADD_FAVORITES")
    static let NOTIFICATION_ID_REMOVE_FAVORITES = NSNotification.Name(rawValue:"NOTIFICATION_ID_REMOVE_FAVORITES")
    static let NOTIFICATION_ID_FAVORITES_OPENED = NSNotification.Name(rawValue:"NOTIFICATION_ID_FAVORITES_OPENED")
    
    var favoritedUnSeenItems:NSMutableArray = NSMutableArray()
    var badge = Variable<String>("");
    
    override init() {
        super.init()
        self.registerLocalNotificaiton()
    }
    deinit {
        unRegisterLocalNotificaiton()
    }
    
    func registerLocalNotificaiton(){
        //register addToFavorites Notifiaciton
        NotificationCenter.default.addObserver(self, selector: #selector(addToFavorites), name:  RootTabViewModel.NOTIFICATION_ID_ADD_FAVORITES  , object: nil)
        //register removeFromFavorites Notificaiton
        NotificationCenter.default.addObserver(self, selector: #selector(removeFromFavorites), name: RootTabViewModel.NOTIFICATION_ID_REMOVE_FAVORITES, object: nil)
        //register favoritedOpened Notificaiton
        NotificationCenter.default.addObserver(self, selector: #selector(favoritedOpened), name: RootTabViewModel.NOTIFICATION_ID_FAVORITES_OPENED, object: nil)
        

    }
    func unRegisterLocalNotificaiton(){
        //remove  observers
        NotificationCenter.default.removeObserver(self, name: RootTabViewModel.NOTIFICATION_ID_ADD_FAVORITES, object: nil)
        NotificationCenter.default.removeObserver(self, name: RootTabViewModel.NOTIFICATION_ID_REMOVE_FAVORITES, object: nil)
        NotificationCenter.default.removeObserver(self, name: RootTabViewModel.NOTIFICATION_ID_FAVORITES_OPENED, object: nil)

    }
    
    
    func addToFavorites(notification:NSNotification){
        favoritedUnSeenItems.add(notification.object as! Vehicle)
        badge.value = "\(favoritedUnSeenItems.count)"
    }
    func removeFromFavorites(notification:NSNotification){
        //Make Sure that this Vehicle was added on the same Session
        if let vehicle:Vehicle = chechIfVehicleExist(vehicle: notification.object as! Vehicle){
            favoritedUnSeenItems.remove(vehicle)
            if(favoritedUnSeenItems.count != 0 ){
               badge.value = "\(favoritedUnSeenItems.count)"
            }else{
                badge.value = ""
            }
        }
        
    }
    
    func favoritedOpened(){
        //ReSet The session
        favoritedUnSeenItems = NSMutableArray()
        badge.value = ""
        
    }
    
    // MARK:- Utils Methods
    
    func chechIfVehicleExist(vehicle:Vehicle)-> Vehicle!{
        let predicate : NSPredicate    = NSPredicate(format: "SELF.iD ==[c] %d", vehicle.iD);
        let filteredArray : NSArray = favoritedUnSeenItems.filtered(using: predicate) as NSArray
        if(filteredArray.count > 0){
            return filteredArray.object(at: 0) as! Vehicle
        }
        
        return nil
        
    }
}
