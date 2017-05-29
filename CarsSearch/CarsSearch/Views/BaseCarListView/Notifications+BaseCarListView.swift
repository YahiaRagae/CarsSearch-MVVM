//
//  Notifications+BaseCarListView.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/29/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
extension BaseCarListView {
    
    static let NOTIFICATION_ID_LOAD_DATA = NSNotification.Name(rawValue: "NOTIFICATION_ID_LOAD_DATA")
    
    
    func registerLocalNotificaiton(){
        //register addToFavorites Notifiaciton
        NotificationCenter.default.addObserver(self, selector: #selector(loadDataRecived), name:  BaseCarListView.NOTIFICATION_ID_LOAD_DATA  , object: nil)
        
        
    }
    func unRegisterLocalNotificaiton(){
        //remove  observers
        NotificationCenter.default.removeObserver(self, name: BaseCarListView.NOTIFICATION_ID_LOAD_DATA, object: nil)
    }
    
    func loadDataRecived(notification:NSNotification){
        loadData(isShowActivityIndicator:  notification.object as! Bool)
    }
    
    
}
