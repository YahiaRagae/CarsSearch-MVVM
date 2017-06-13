//
//  VehicleTableCellViewModel.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/29/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
class VehicleTableCellViewModel: NSObject {
    
    var vehicle:Vehicle;
    var firstImage: String
    var make: String
    var firstRegistration: String
    var address: String
    var mileage: String
    var fuelType: String
    var backGroundColor: UIColor =  UIColor.white
    var price: String
    var index: Int
    var selectionStyle: UITableViewCellSelectionStyle
    var addressLabelIsHiddenStatus : Bool = true
    var cellType : CellType
    
    var deleteButtonIsHiddenStatus : Bool = false
    var favoriteSwitchIsHiddenStatus : Bool = false
    var favoriteSwitchIsEnabledStatus : Bool = false
    
    enum CellType:String {
        case Favorites = "Favorites"
        case CARS = "CARS"
        
    }
    
    
    init(vehicle:Vehicle , index:Int,cellType : CellType) {
        self.vehicle = vehicle;
        self.cellType = cellType
        
        firstImage = vehicle.images[0];
        make = "\(vehicle.make )"
        firstRegistration = "\(vehicle.firstRegistration )"
        address = "\(vehicle.address )"
        mileage = "\(vehicle.mileage )"
        fuelType = "\(vehicle.fuelType )"
        
        price = "\(vehicle.price )"
        
        if(vehicle.accidentFree){
            backGroundColor = UIColor.white
            favoriteSwitchIsEnabledStatus = true ;
        }else{
            backGroundColor = UIColor.lightGray
            favoriteSwitchIsEnabledStatus = false 
        }
        
        self.index = index
        selectionStyle = .none
        
        switch self.cellType {
            case .CARS:
                deleteButtonIsHiddenStatus = true ;
                favoriteSwitchIsHiddenStatus = false ;
            
            case .Favorites:
                deleteButtonIsHiddenStatus = false ;
                favoriteSwitchIsHiddenStatus = true ;
            
        }

    }
    
    func checkFavoriteStatus()->Bool{
        return DataAccessController.sharedInstance.checkFavorite(vehicle: self.vehicle)
    }
    
    func OnConfigureDidCalled(compilation:(( )->Void)!){
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async(execute: {
                self.addressLabelIsHiddenStatus = false
                compilation()
            })
        }
        
    }
    
    
    
    func processFavoritesAt( ){
        DataAccessController.sharedInstance.processFavorites(vehicle: vehicle)
    }
    func sendFavoritesStatusLocalNotification(status:Bool ){
        if(status)
        {
            NotificationCenter.default.post(name: RootTabViewModel.NOTIFICATION_ID_ADD_FAVORITES , object: vehicle)
        }else{
            NotificationCenter.default.post(name: RootTabViewModel.NOTIFICATION_ID_REMOVE_FAVORITES , object: vehicle)
        }
    }
    
    func sendReloadDataStatusLocalNotification(isShowActivityIndicator:Bool){
        NotificationCenter.default.post(name: BaseCarListView.NOTIFICATION_ID_LOAD_DATA , object: isShowActivityIndicator)
        
    }
}
