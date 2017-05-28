//
//  RootTabViewModelProtocol.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
protocol RootTabViewModelProtocol {
    func registerLocalNotificaiton();
    func unRegisterLocalNotificaiton();
    func addToFavorites(notification:NSNotification);
    func removeFromFavorites(notification:NSNotification);
    func favoritedOpened();
    func chechIfVehicleExist(vehicle:Vehicle)-> Vehicle!;
}
