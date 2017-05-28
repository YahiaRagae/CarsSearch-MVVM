//
//  BaseCarListView.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//


import Foundation
import UIKit
import MBProgressHUD
class BaseCarListView: UIViewController,UITableViewDataSource {
    
    let mv:CarListViewModel = CarListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchFilterAll: UISwitch!
    @IBOutlet weak var switchFilterBMW: UISwitch!
    @IBOutlet weak var switchFilterAUDI: UISwitch!
    @IBOutlet weak var switchFilterMERCEDES: UISwitch!
    
    var refreshView :UIRefreshControl!
    var isPullToRefreshEnable: Bool = false {
        didSet{
            if(refreshView != nil ){
                return
            }
            refreshView = UIRefreshControl()
            
            if #available(iOS 10.0, *) {
                tableView.refreshControl = refreshView
            } else {
                tableView.addSubview(refreshView)
            }
            refreshView.addTarget(self, action: #selector(loadData), for:.valueChanged)
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
    // MARK:- Helper Methods
    
    /// initialization of non views objects
    func initData(){
        mv.initData();
    }
    
    /// initialization related to the views
    func initViews(){
        
        //Register UITable Cell
        self.tableView.register(UINib(nibName: "VehicleTableViewCell", bundle: nil), forCellReuseIdentifier: "VehicleTableViewCell")
        
        //Add Filters Button
        self.navigationItem.rightBarButtonItem = sortNavButton()
    }
    
    /// Load The data
    /// - parameter isShowActivityIndicator: True to show The Activity Inndicator and False to hide it
    func loadData(isShowActivityIndicator:Bool){
        activityIndeicator(isShow: isShowActivityIndicator)
    }
    
    /// Show / Hide Activity Indeicator
    /// - parameter isShow: True to show The Activity Inndicator and False to hide it
    func activityIndeicator(isShow:Bool){
        if(isShow){
            hud = MBProgressHUD.showAdded(to:  self.tableView, animated: true)
            hud.label.text = "loading"
            hud.mode = .indeterminate
        }else{
            MBProgressHUD.hide(for: self.tableView, animated: true)
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
    
    func getItems()->NSMutableArray{
        return mv.getSortedList();
    }
    // MARK:- UITableView Deata Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mv.getSortedList().count;
    }
    
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vehicle : Vehicle = mv.getVehiclefor(index: indexPath.row)
        
        let   cell : VehicleTableViewCell  =  self.tableView.dequeueReusableCell(withIdentifier: "VehicleTableViewCell")! as! VehicleTableViewCell ;
        
        cell.lblFuelType.text = "\(vehicle.fuelType )"
        cell.lblMake.text =  "\(vehicle.make )"
        cell.lblPrice.text =  "\(vehicle.price )"
        cell.lblMilage.text = "\(vehicle.mileage )"
        cell.lblRegistrationFirst.text = "\(vehicle.firstRegistration )"
        
        cell.selectionStyle = .none
        
        cell.img.imageFromUrl(urlString: vehicle.images[0])
        
        if(vehicle.accidentFree){
            cell.backgroundColor = UIColor.white
        }else{
            cell.backgroundColor = UIColor.lightGray
        }
        
        cell.lblAddress.isHidden = true
        cell.lblAddress.text = vehicle.address;
        cell.actAddress.startAnimating()
        
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async(execute: {
                cell.lblAddress.isHidden=false
                cell.actAddress.stopAnimating()
            })
        }
        return cell
    }
    
    // MARK:- IBActions Methods
    
    @IBAction func onFilterValueChanged(_ sender: UISwitch) {
        if(sender.isOn){
            switch(sender.tag){
            case switchFilterAll.tag:
                switchFilterBMW.setOn(false, animated: true)
                switchFilterAUDI.setOn(false, animated: true)
                switchFilterMERCEDES.setOn(false, animated: true)
                
                mv.filter = Filter.All
                
            case switchFilterBMW.tag:
                
                switchFilterAll.setOn(false, animated: true)
                switchFilterAUDI.setOn(false, animated: true)
                switchFilterMERCEDES.setOn(false, animated: true)
                
                mv.filter = Filter.BMW
                
            case switchFilterAUDI.tag:
                
                switchFilterAll.setOn(false, animated: true)
                switchFilterBMW.setOn(false, animated: true)
                switchFilterMERCEDES.setOn(false, animated: true)
                
                mv.filter = Filter.AUDI
                
            case switchFilterMERCEDES.tag:
                
                switchFilterAll.setOn(false, animated: true)
                switchFilterBMW.setOn(false, animated: true)
                switchFilterAUDI.setOn(false, animated: true)
                
                mv.filter = Filter.MERCEDES
                
            default:
                NSLog("none")
                
            }
            loadData(isShowActivityIndicator: true)
        }else{
            mv.removeAllObjects()
            self.tableView.reloadData()
        }
    }
    
}
