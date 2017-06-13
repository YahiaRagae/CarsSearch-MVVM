//
//  DataAccessController.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

// Desgin Pattern : Singleton
// Description :  This is a Data Access Layer which is the over all applcation data source  



enum Filter:String {
    case All = "all"
    case BMW = "bmw"
    case AUDI = "audi"
    case MERCEDES = "mercedes-benz"
}


//MARK: Protocol
protocol DataAccessControllerInterface{
    func getCars(withFilter filter : Filter , completion: ((NSMutableArray,  String?) -> Void)?)
}

//MARK: Class

class DataAccessController : DataAccessControllerInterface {
    
    //Singleton Access
    static let sharedInstance = DataAccessController()

    
    //Image Cache
    let imageCache = AutoPurgingImageCache()
    
    
    //Variables
    private var dataReposetory:DataReposetory!
    var favoritesController:FavoritesController!
       
    //Init and Init Helpers
    private init() {
        dataReposetory = DataReposetory()
        favoritesController = FavoritesController.sharedInstance
    }
    
    func setNewDataSource(source: DataSources) {
        dataReposetory.setNewDataSource(source: source)
    }
    // MARK:- Getting Data
    func getCars(withFilter filter: Filter, completion: ((NSMutableArray, String?) -> Void)?) {
        self.dataReposetory?.getDataSource().getCars(withFilter: filter, completion: completion)
    }

    // MARK:- Favorites
    
    func getFavorite(withFilter  filter:Filter  ) -> NSMutableArray{
        return favoritesController.getFavorite(withFilter:filter)
    }
    
    func processFavorites(vehicle : Vehicle){
        favoritesController.processFavorite(vehicle: vehicle)
    }
    
    func checkFavorite(vehicle : Vehicle)->Bool{
        return         favoritesController.checkFavorite(vehicle: vehicle)

    }
    
}

