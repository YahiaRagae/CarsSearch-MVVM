//
//  CarListViewController.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit

class CarListViewController : BaseCarListViewController{
    // MARK:- ViewController Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.items = self.getSortedList()
        self.tableView.reloadData()
    }
    
    // MARK:- Helper Methods
    override func initViews() {
        super.initViews()
        self.isPullToRefreshEnable = true
    }
    override func loadData(isShowActivityIndicator: Bool) {
        super.loadData(isShowActivityIndicator: isShowActivityIndicator)
        
        DataAccessController.sharedInstance.getCars(withFilter: filter) { (_items, errorMessage) in
            if(errorMessage != nil && _items.count == 0 ){
                self.tableView.makeToast(errorMessage, duration: 2.0, position: "CSToastPositionCenter")
            }
            self.orginalItems = _items.mutableCopy()   as! NSMutableArray
            self.items = self.getSortedList()
            
            
            self.tableView.reloadData()
            self.loadingDidEnd()
        }
    }
    
    // MARK:- UITableView Deata Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   cell = super.tableView(self.tableView, cellForRowAt: indexPath) as! VehicleTableViewCell
        let vehicle : Vehicle = self.items[indexPath.row] as! Vehicle
        
        
        cell.switchFavorite.isHidden = false
        cell.switchFavorite.tag = indexPath.row
        cell.switchFavorite.addTarget(self, action: #selector(onValueChanged), for: UIControlEvents.valueChanged)
        
        cell.switchFavorite.setOn(DataAccessController.sharedInstance.checkFavorite(vehicle: vehicle), animated: false)
        
        if(vehicle.accidentFree){
            cell.switchFavorite.isEnabled = true
        }else{
            cell.switchFavorite.isEnabled = false
        }
        
        return cell;
    }
    // MARK:- IBActions Methods
    func onValueChanged(sender: UISwitch) {
        let vehicle : Vehicle = self.items[sender.tag] as! Vehicle
        DataAccessController.sharedInstance.processFavorites(vehicle: vehicle)
    }
    
    
}
