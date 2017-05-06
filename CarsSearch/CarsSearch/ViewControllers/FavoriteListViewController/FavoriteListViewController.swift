//
//  FavoriteListViewController.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
class FavoriteListViewController : BaseCarListViewController{
    // MARK:- ViewController Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(isShowActivityIndicator: true)
    }
    
    // MARK:- Helper Methods
    override func loadData(isShowActivityIndicator: Bool) {
        super.loadData(isShowActivityIndicator: isShowActivityIndicator)
        items = DataAccessController.sharedInstance.getFavorite(withFilter: filter)
        self.tableView.reloadData()
        
        loadingDidEnd()
    }
    
    // MARK:- UITableView Deata Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   cell = super.tableView(self.tableView, cellForRowAt: indexPath) as! VehicleTableViewCell
        
        cell.btnFavorite.isHidden = false
        cell.btnFavorite.tag = indexPath.row
        cell.btnFavorite.addTarget(self, action: #selector(deleteVehicle), for: UIControlEvents.touchUpInside)
        
        
        return cell;
    }
    // MARK:- IBActions Methods
    func deleteVehicle(sender: UIButton) {
        let vehicle : Vehicle = self.items[sender.tag] as! Vehicle
        DataAccessController.sharedInstance.processFavorites(vehicle: vehicle)
        loadData(isShowActivityIndicator: true)
    }
}
