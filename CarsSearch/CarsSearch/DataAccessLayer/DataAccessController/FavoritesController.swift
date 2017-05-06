//
//  DBController.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import SwiftyJSON

class FavoritesController : NSObject  {
    static let FAVORITES_LIST  = "FAVORITES_LIST";
    //Singleton Access
    static let sharedInstance = FavoritesController()
    private var favorites:NSMutableArray!
    //Init and Init Helpers
    private override init() {
        favorites=NSMutableArray()
        
        let defaults = UserDefaults.standard
        var   favoritesDictionary : NSMutableDictionary!
        if( defaults.value(forKey: FavoritesController.FAVORITES_LIST) != nil){
            favoritesDictionary  = defaults.value(forKey: FavoritesController.FAVORITES_LIST) as! NSMutableDictionary
            
            for  i in 0 ..< favoritesDictionary.allKeys.count {
                let data:Data  = favoritesDictionary.object(forKey: favoritesDictionary.allKeys[i]) as! Data
                
                let vehicle : Vehicle = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! Vehicle
                favorites.add(vehicle)
            }
        }
    }
    
    func processFavorite(vehicle:Vehicle )  {
        if(checkFavorite(vehicle:vehicle)){
            removeFavorites(vehicle:vehicle)
        }else{
            addToFavorites(vehicle:vehicle)
        }
    }
    func checkFavorite(  vehicle:Vehicle ) -> Bool {
        let predicate : NSPredicate    = NSPredicate(format: "SELF.iD == %d", vehicle.iD);
        let filteredArray : NSArray = favorites.filtered(using: predicate) as NSArray
        if(filteredArray.count > 0){
            return true
        }
        return false
    }
    
    func addToFavorites(vehicle:Vehicle)  {
        favorites.add(vehicle)
        //Add Vehicle to NSUserDefualts
        
        let defaults = UserDefaults.standard
        var   favoritesDictionary : NSMutableDictionary!
        
        
        if( defaults.value(forKey: FavoritesController.FAVORITES_LIST) != nil){
            favoritesDictionary  = (defaults.value(forKey: FavoritesController.FAVORITES_LIST) as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary
        }else{
            favoritesDictionary = NSMutableDictionary()
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: vehicle)
        favoritesDictionary.setObject(data, forKey:"\(vehicle.iD)" as NSCopying)
        defaults.set(favoritesDictionary, forKey: FavoritesController.FAVORITES_LIST)
        defaults.synchronize()
        
    }
    
    func removeFavorites(vehicle:Vehicle)  {
        favorites.remove(vehicle)
        
        let defaults = UserDefaults.standard
        var   favoritesDictionary : NSMutableDictionary = NSMutableDictionary()
        if( defaults.value(forKey: FavoritesController.FAVORITES_LIST) != nil){
            favoritesDictionary = (defaults.value(forKey: FavoritesController.FAVORITES_LIST) as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary

            favoritesDictionary.removeObject(forKey: "\(vehicle.iD)" as NSCopying)
        }else{
            favoritesDictionary = NSMutableDictionary()
        }
        
        defaults.set(favoritesDictionary, forKey: FavoritesController.FAVORITES_LIST)
        defaults.synchronize()
    }
    
    
    func getFavorite(withFilter  filter:Filter  ) -> NSMutableArray {
        if(filter == Filter.All){
            return favorites.mutableCopy() as! NSMutableArray;
        }
        let predicate : NSPredicate    = NSPredicate(format: "SELF.make ==[c] %@", filter.rawValue);
        let filteredArray : NSArray = favorites.filtered(using: predicate) as NSArray
        if(filteredArray.count > 0){
            return filteredArray.mutableCopy() as! NSMutableArray
        }
        return NSMutableArray()
    }
}
