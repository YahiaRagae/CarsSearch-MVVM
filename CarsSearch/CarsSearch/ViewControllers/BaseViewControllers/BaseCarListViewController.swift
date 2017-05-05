//
//  BaseCarListViewController.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit

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
    
    // MARK:- ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData();
        initViews();
        loadData(); 

    }
    
    // MARK:- Class Methods
    func initData(){
        items = NSMutableArray()
    }
    func initViews(){
        
    }
    func loadData(){
        
    }
    // MARK:- UITableView Deata Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    
    
    
}
