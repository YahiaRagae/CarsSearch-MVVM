//
//  BaseCarListViewController.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
class BaseCarListViewController:UITableViewController{
    var items:NSMutableArray!;
    var refreshView :UIRefreshControl!
    
    var isPullToRefreshEnable: Bool = false {
        didSet{
            if(refreshView != nil ){
                return
            }
            refreshView = UIRefreshControl()
            refreshView.addTarget(self, action: #selector(loadData), for:.valueChanged)
            tableView.addSubview(refreshView) // not required when using UITableViewController
        }
    }
    
    
    var hud : MBProgressHUD!;
    // MARK:- ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData();
        initViews();
        loadData(isShowActivityIndicator: true);
        
    }
    
    // MARK:- Class Methods
    
    /// initialization of non views objects
    func initData(){
        items = NSMutableArray()
    }
    
    /// initialization related to the views
    func initViews(){
        
        self.tableView.register(UINib(nibName: "VehicleTableViewCell", bundle: nil), forCellReuseIdentifier: "VehicleTableViewCell")
        
    }
    
    /// Load The data
    /// - parameter isShowActivityIndicator: True to show The Activity Inndicator and False to hide it
    func loadData(isShowActivityIndicator:Bool){
        activityIndeicator(isShow: isShowActivityIndicator)
    }
    
    /// Show / Hide Activity Indeicator
    /// - parameter isShow: True to show The Activity Inndicator and False to hide it
    func activityIndeicator(isShow:Bool){
        if(hud == nil){
            hud = MBProgressHUD.showAdded(to: self.tableView, animated: true)
            hud.label.text = "loading"
            hud.mode = .indeterminate
        }
        if(isShow){
            if(hud.isHidden){
                hud.show(animated: true)
            }
        }else{
            hud.hide(animated: true)
        }
    }
    
    /// Call it when Data is Available
    func loadingDidEnd(){
        if(self.refreshView != nil && self.refreshView.isRefreshing){
            self.refreshView.endRefreshing()
        }
        
        if(hud != nil && !hud.isHidden){
            activityIndeicator(isShow: false)
        }
    }
    // MARK:- UITableView Deata Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    override public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vehicle : Vehicle = self.items[indexPath.row] as! Vehicle
        let   cell : VehicleTableViewCell  =  self.tableView.dequeueReusableCell(withIdentifier: "VehicleTableViewCell")! as! VehicleTableViewCell ;
        cell.lblFuelType.text = "\(vehicle.fuelType )"
        cell.lblMake.text =  "\(vehicle.make )"
        cell.lblPrice.text =  "\(vehicle.price )"
        cell.lblMilage.text = "\(vehicle.mileage )"
        cell.selectionStyle = .none
        return cell
    }
    
    
}
