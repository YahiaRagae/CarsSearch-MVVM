//
//  FavoriteListView.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
import AFViewShaker

class FavoriteListView:BaseCarListView  {
    @IBOutlet weak var viewCalculateBar: UIView!
    @IBOutlet weak var tfAmount: UITextField!
    
    var viewShaker:AFViewShaker!
    let calculationBarVM:CalculationBarViewModel = CalculationBarViewModel();
    
    override func initViews() {
        super.initViews()
        viewShaker = AFViewShaker(view: tfAmount)
    }
    
    // MARK:- ViewController Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(isShowActivityIndicator: true)
        
        NotificationCenter.default.post(name: RootTabViewModel.NOTIFICATION_ID_FAVORITES_OPENED , object: nil)
        
        resetCalculateBarBg()
    }
    
    // MARK:- Helper Methods
    override func loadData(isShowActivityIndicator: Bool) {
        super.loadData(isShowActivityIndicator: isShowActivityIndicator)
        mv.loadCarsFromFavorites();
        self.tableView.reloadData()
        loadingDidEnd()
        
        //Reset Calcuate Bar Bg
        resetCalculateBarBg()
    }
    func resetCalculateBarBg(){
        viewCalculateBar.backgroundColor = UIColor.white
    }
    // MARK:- UITableView Deata Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   cell = super.tableView(self.tableView, cellForRowAt: indexPath) as! VehicleTableViewCell
        cell.mv = mv.viewModelForCell(at: indexPath.row, with: .Favorites)
        return cell;
    }
    
    // MARK:- IBActions Methods
    @IBAction func btnClaculate(sender: UIButton) {
        let amountStr : String = tfAmount.text!
        if let amount = Int(amountStr) {
            viewCalculateBar.backgroundColor = calculationBarVM.barColor(items: mv.getSortedList(), amount: amount)
        }else{
            viewShaker.shake()
        }
    }
    
}
