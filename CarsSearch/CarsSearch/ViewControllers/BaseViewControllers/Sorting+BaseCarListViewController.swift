//
//  Sorting+BaseCarListViewController.swift
//  CarsSearch
//
//  Created by Yahia on 5/6/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
import DynamicButton
extension BaseCarListViewController {
    
    
    static var sortBy:SortBy = SortBy.Standered
    
    ///Sort Type
    enum SortBy{
        case Standered
        case FirstRegistrationAscending
        case FirstRegistrationDescending
    }
    
    
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

    
    func sortArrayByFirstRegistration(by:SortBy, items:NSMutableArray)-> NSMutableArray{
        let sortedArray : NSMutableArray =  items.sorted(by: { (obj1, obj2) -> Bool in
            let vehicle1 =  (obj1 as! Vehicle)
            let vehicle2 =  (obj2 as! Vehicle)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/yyyy"
            
            let date1 = dateFormatter.date(from: vehicle1.firstRegistration)
            let vehicle1RegistrationFirstIntervals:Double = (date1?.timeIntervalSince1970)!
            
            
            let date2 = dateFormatter.date(from: vehicle2.firstRegistration)
            let vehicle2RegistrationFirstIntervals:Double = (date2?.timeIntervalSince1970)!
            
            if(by == SortBy.FirstRegistrationDescending){
                return vehicle1RegistrationFirstIntervals > vehicle2RegistrationFirstIntervals
            }else{
                return vehicle1RegistrationFirstIntervals < vehicle2RegistrationFirstIntervals
            }
        }) as! NSMutableArray
        
        return sortedArray.mutableCopy() as! NSMutableArray
    }
    
    func getSortedList()-> NSMutableArray{
        
        switch(BaseCarListViewController.sortBy){
        case .Standered :
            return  self.orginalItems.mutableCopy() as! NSMutableArray;
            
        case .FirstRegistrationDescending :
            return  self.sortArrayByFirstRegistration(by: SortBy.FirstRegistrationDescending, items: (self.orginalItems.mutableCopy() as! NSMutableArray))

            
        case .FirstRegistrationAscending :
             return  self.sortArrayByFirstRegistration(by: SortBy.FirstRegistrationAscending, items: (self.orginalItems.mutableCopy() as! NSMutableArray))
            
        } 
    }
    
    // MARK:- IBActions Methods
    @IBAction func openSortMenu(_ sender: UISwitch) {
        let filtersMenu = UIAlertController(title: nil, message: "Filters", preferredStyle: .actionSheet)
        
        
        let standeredFilter = UIAlertAction(title: "Standered", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            BaseCarListViewController.sortBy = SortBy.Standered
            self.items = self.getSortedList()
            self.tableView.reloadData()
        })
        let firstRegistrationDescending = UIAlertAction(title: "first Registration ↓", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            BaseCarListViewController.sortBy = SortBy.FirstRegistrationDescending
            self.items = self.getSortedList()
            self.tableView.reloadData()
        })
        
        
        let firstRegistrationAscending = UIAlertAction(title: "first Registration ↑", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            BaseCarListViewController.sortBy = SortBy.FirstRegistrationAscending
            self.items = self.getSortedList()
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
