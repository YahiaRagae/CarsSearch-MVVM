//
//  CarListView.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
class CarListView: BaseCarListView {
    
    // MARK:- ViewController Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK:- Helper Methods
    override func initViews() {
        super.initViews()
        self.isPullToRefreshEnable = true
    }
    
    override func loadData(isShowActivityIndicator: Bool) {
        super.loadData(isShowActivityIndicator: isShowActivityIndicator)
        mv.loadCarsFromInternet { (errorMessage) in
            if(errorMessage != nil  ){
                self.tableView.makeToast(errorMessage, duration: 2.0, position: "CSToastPositionCenter")
            }else{
                self.tableView.reloadData()
            }
            self.loadingDidEnd()
        }
    }
    
    // MARK:- UITableView Deata Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   cell = super.tableView(self.tableView, cellForRowAt: indexPath) as! VehicleTableViewCell
        let vehicle : Vehicle = mv.getVehiclefor(index: indexPath.row)
        
        
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
        mv.processFavoritesAt(index: sender.tag)
        mv.sendLocalNotificationFor(status: sender.isOn, and: sender.tag)
        
    }
    
    
}
