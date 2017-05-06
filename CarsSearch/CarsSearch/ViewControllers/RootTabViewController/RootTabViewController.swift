//
//  RootTabViewController.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
class RootTabViewController: UITabBarController{
    static let NOTIFICATION_ID_ADD_FAVORITES = "NOTIFICATION_ID_ADD_FAVORITES"
    static let NOTIFICATION_ID_REMOVE_FAVORITES = "NOTIFICATION_ID_REMOVE_FAVORITES"
    static let NOTIFICATION_ID_FAVORITES_OPENED = "NOTIFICATION_ID_FAVORITES_OPENED"
    
    var favoritedUnSeenItems:NSMutableArray = NSMutableArray()
    
    // MARK:- ViewController Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register addToFavorites Notifiaciton
        NotificationCenter.default.addObserver(self, selector: #selector(addToFavorites), name:NSNotification.Name(rawValue: RootTabViewController.NOTIFICATION_ID_ADD_FAVORITES) , object: nil)
        //register removeFromFavorites Notificaiton
        NotificationCenter.default.addObserver(self, selector: #selector(removeFromFavorites), name: NSNotification.Name(rawValue: RootTabViewController.NOTIFICATION_ID_REMOVE_FAVORITES), object: nil)
        //register favoritedOpened Notificaiton
        NotificationCenter.default.addObserver(self, selector: #selector(favoritedOpened), name: NSNotification.Name(rawValue: RootTabViewController.NOTIFICATION_ID_FAVORITES_OPENED), object: nil)
        
        
    }
    deinit{
        //remove  observers
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: RootTabViewController.NOTIFICATION_ID_ADD_FAVORITES), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: RootTabViewController.NOTIFICATION_ID_REMOVE_FAVORITES), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: RootTabViewController.NOTIFICATION_ID_FAVORITES_OPENED), object: nil)
    }
    
    // MARK:- Helpers Methods
    
    func addToFavorites(notification:NSNotification){
        favoritedUnSeenItems.add(notification.object as! Vehicle)
        self.viewControllers?[1].tabBarItem.badgeValue = "\(favoritedUnSeenItems.count)"
    }
    func removeFromFavorites(notification:NSNotification){
        //Make Sure that this Vehicle was added on the same Session
        if let vehicle:Vehicle = chechIfVehicleExist(vehicle: notification.object as! Vehicle){
            favoritedUnSeenItems.remove(vehicle)
            if(favoritedUnSeenItems.count != 0 ){
                self.viewControllers?[1].tabBarItem.badgeValue = "\(favoritedUnSeenItems.count)"
            }else{
                self.viewControllers?[1].tabBarItem.badgeValue = nil
            }
        }
        
    }
    
    func favoritedOpened(){
        //ReSet The session
        favoritedUnSeenItems = NSMutableArray()
        self.viewControllers?[1].tabBarItem.badgeValue = nil
        
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
