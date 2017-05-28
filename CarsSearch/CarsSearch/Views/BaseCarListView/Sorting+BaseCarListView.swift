//
//  Sorting+BaseCarListView.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation

import UIKit
import DynamicButton
extension BaseCarListView { 
    
    
    // MARK:- Helper Methods
    
    open func  sortNavButton () -> UIBarButtonItem{
        let filtersButton = DynamicButton(style: DynamicButton.Style.none)
        
        filtersButton.addTarget(self, action: #selector(openSortMenu), for: .touchUpInside)
        let newFrame : CGRect =  CGRect(x: 10, y: 10, width: 20, height: 20);
        filtersButton.frame = newFrame
        
        filtersButton.setImage(UIImage(named: "ic_sort"), for: UIControlState.normal)
        let menuButtonItem : UIBarButtonItem = UIBarButtonItem.init(customView: filtersButton)
        return menuButtonItem;
        
    }
    
    
     
    
    // MARK:- IBActions Methods
    @IBAction func openSortMenu(_ sender: UISwitch) {
        let filtersMenu = UIAlertController(title: nil, message: "Filters", preferredStyle: .actionSheet)
        
        
        let standeredFilter = UIAlertAction(title: "Standered", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            CarListViewModel.sortBy = .Standered;
            self.tableView.reloadData()
        })
        let firstRegistrationDescending = UIAlertAction(title: "first Registration ↓", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            CarListViewModel.sortBy = .FirstRegistrationDescending;
            self.tableView.reloadData()
        })
        
        
        let firstRegistrationAscending = UIAlertAction(title: "first Registration ↑", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            CarListViewModel.sortBy = .FirstRegistrationAscending;
            self.tableView.reloadData()
        })
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        
        filtersMenu.addAction(standeredFilter)
        filtersMenu.addAction(firstRegistrationDescending)
        filtersMenu.addAction(firstRegistrationAscending)
        filtersMenu.addAction(cancel)
        
        
        self.present(filtersMenu, animated: true, completion: nil)
    }
}
