//
//  BaseCarListView.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
class CarListViewModel:NSObject {
    
    var items:NSMutableArray!;
    var orginalItems:NSMutableArray!;
    var filter:Filter = Filter.All
    
    static var sortBy:SortBy = SortBy.Standered

    
    ///Sort Type
    enum SortBy{
        case Standered
        case FirstRegistrationAscending
        case FirstRegistrationDescending
    }
    
    override init() {
        super.init()
        
    }
    func initData(){
        items = NSMutableArray()
        orginalItems = NSMutableArray()

    }
    
    func getItems()->NSMutableArray{
        return getSortedList();
    }
    func getVehiclefor(index:Int)->Vehicle{
        return  self.items[index] as! Vehicle;
    }
    func removeAllObjects(){
        items.removeAllObjects()
    }
    
    func getSortedList()-> NSMutableArray{
        
        switch(CarListViewModel.sortBy){
        case .Standered :
            items =   self.orginalItems.mutableCopy() as! NSMutableArray;
            
        case .FirstRegistrationDescending :
            items =   self.sortArrayByFirstRegistration(by: SortBy.FirstRegistrationDescending, items: (self.orginalItems.mutableCopy() as! NSMutableArray))
            
            
        case .FirstRegistrationAscending :
            items =   self.sortArrayByFirstRegistration(by: SortBy.FirstRegistrationAscending, items: (self.orginalItems.mutableCopy() as! NSMutableArray))
            
        }
        
        return items;
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


}
