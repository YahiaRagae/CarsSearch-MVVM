//
//  FavoriteListView.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
class FavoriteListView:BaseCarListView  {
    weak var rootVC:FavoritesRootViewController!
    
    override func initViews() {
        super.initViews()
        if(self.navigationController == nil && self.rootVC != nil  ){
            //Add Filters Button
            self.rootVC.navigationItem.rightBarButtonItem = sortNavButton()
        }
    }
    
    // MARK:- ViewController Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(isShowActivityIndicator: true)
        
        NotificationCenter.default.post(name: RootTabViewModel.NOTIFICATION_ID_FAVORITES_OPENED , object: nil)
    }
    
    // MARK:- Helper Methods
    override func loadData(isShowActivityIndicator: Bool) {
        super.loadData(isShowActivityIndicator: isShowActivityIndicator)
        mv.loadCarsFromFavorites();
        self.tableView.reloadData()
        loadingDidEnd()
        
        //Reset Calcuate Bar Bg
        rootVC.resetCalculateBarBg()
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
        mv.processFavoritesAt(index: sender.tag)
        loadData(isShowActivityIndicator: true)
    }
}
