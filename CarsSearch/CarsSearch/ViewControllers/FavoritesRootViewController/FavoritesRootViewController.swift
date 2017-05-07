//
//  FavoritesRootViewController.swift
//  CarsSearch
//
//  Created by Yahia on 5/7/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
class FavoritesRootViewController:UIViewController{
    var favoriteListViewController:FavoriteListViewController!
    
    // MARK:- ViewController Life Cycle Methods
    deinit {
        favoriteListViewController = nil 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "embedFavoritesVC"){
            favoriteListViewController = segue.destination as! FavoriteListViewController
            favoriteListViewController.rootVC = self
        }
        
        
        
    }
    
    // MARK:- Helper Methods
    
    // MARK:- IBActions Methods
    func btnClaculate(sender: UIButton) {
        
    }
}
