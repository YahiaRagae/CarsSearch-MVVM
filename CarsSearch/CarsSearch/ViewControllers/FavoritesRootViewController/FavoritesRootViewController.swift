//
//  FavoritesRootViewController.swift
//  CarsSearch
//
//  Created by Yahia on 5/7/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
import AFViewShaker
class FavoritesRootViewController:UIViewController{
    @IBOutlet weak var viewCalculateBar: UIView!
    var favoriteListViewController:FavoriteListView!
    var viewShaker:AFViewShaker!
    @IBOutlet weak var tfAmount: UITextField!
    // MARK:- ViewController Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        resetCalculateBarBg()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init AFViewShaker
        viewShaker = AFViewShaker(view: tfAmount)
    }
    deinit {
        favoriteListViewController = nil 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "embedFavoritesVC"){
            favoriteListViewController = segue.destination as! FavoriteListView
            favoriteListViewController.rootVC = self
        }
        
    }
    
    // MARK:- Helper Methods
    func resetCalculateBarBg(){
        viewCalculateBar.backgroundColor = UIColor.white
    }
    func checkAmount(amount : Int)->Bool{
        var totalAmount:Int = 0
        let items:NSMutableArray = favoriteListViewController.getItems()
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
    // MARK:- IBActions Methods
    @IBAction func btnClaculate(sender: UIButton) {
        let amountStr : String = tfAmount.text!
        if let amount = Int(amountStr) {
            if(checkAmount(amount: amount)){
                viewCalculateBar.backgroundColor = UIColor.green
            }else{
                viewCalculateBar.backgroundColor = UIColor.red
            }
        }else{
            viewShaker.shake()
        }
    }
}
