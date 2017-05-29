//
//  CalculationBarViewModel.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
class CalculationBarViewModel: NSObject {
    
    func barColor(items:NSMutableArray , amount : Int)->UIColor{
        if(checkAmount(items: items, amount: amount) ){
            return UIColor.green
        }else{
            return UIColor.red
        }

    }
    
    func checkAmount(items:NSMutableArray , amount : Int)->Bool{
        var totalAmount:Int = 0
        for i in 0 ..< items.count{
            let vehicle:Vehicle = items.object(at: i) as! Vehicle
            totalAmount += vehicle.price
        }
        if(amount>=totalAmount){
            return true;
        }else{
            return false
        }
    }
}
