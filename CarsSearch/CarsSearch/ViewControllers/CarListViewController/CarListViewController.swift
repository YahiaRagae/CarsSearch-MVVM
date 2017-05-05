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
    let defaultNAValue="N/A"
    // MARK:- Class Methods
    override func initViews() {
        super.initViews()
        self.isPullToRefreshEnable = true
    }
    override func loadData(isShowActivityIndicator: Bool) {
        super.loadData(isShowActivityIndicator: isShowActivityIndicator)
        
        DataAccessController.sharedInstance.getAllCars { (_items, resultCode) in
            self.items.removeAllObjects();
            self.items.addObjects(from: _items as! [Any])
            self.tableView.reloadData()
            self.loadingDidEnd()
        }
    }
    
    // MARK:- UITableView Deata Source Methods
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vehicle : Vehicle = self.items[indexPath.row] as! Vehicle
        let   cell : VehicleTableViewCell  =  self.tableView.dequeueReusableCell(withIdentifier: "VehicleTableViewCell")! as! VehicleTableViewCell ;
        cell.lblFuelType.text = "\(vehicle.fuelType ?? defaultNAValue)"
        cell.lblMake.text =  "\(vehicle.make ?? defaultNAValue)"
        cell.lblPrice.text =  "\(vehicle.price ?? 0)"
        cell.lblMilage.text = "\(vehicle.mileage ?? 0)"
        return cell;
     }
    
    
    // MARK:- IBActions Methods
}
