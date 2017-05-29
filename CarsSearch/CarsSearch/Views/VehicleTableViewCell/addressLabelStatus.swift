//
//  VehicleTableViewswift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import UIKit
class VehicleTableViewCell:UITableViewCell{
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblMilage: UILabel!
    @IBOutlet weak var lblMake: UILabel!
    @IBOutlet weak var lblFuelType: UILabel!
    @IBOutlet weak var lblRegistrationFirst: UILabel!
    
    @IBOutlet weak var actAddress: UIActivityIndicatorView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var switchFavorite: UISwitch!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    var mv:VehicleTableViewModel!{
        didSet{
             configure()
        }
    }
    
  

    
    func configure(){
        selectionStyle = mv.selectionStyle
        lblFuelType.text = mv.fuelType
        lblMake.text =  mv.make
        lblPrice.text =  mv.price
        lblMilage.text = mv.mileage
        lblRegistrationFirst.text = mv.firstRegistration
        
        img.imageFromUrl(urlString: mv.firstImage)
        backgroundColor = mv.backGroundColor

        lblAddress.isHidden = mv.addressLabelIsHiddenStatus
        lblAddress.text = mv.address;
        actAddress.startAnimating()

        mv.OnConfigureDidCalled {
            self.lblAddress.isHidden =   self.mv.addressLabelIsHiddenStatus
            self.actAddress.stopAnimating()
        }
        
        switchFavorite.isHidden = mv.favoriteSwitchIsHiddenStatus
        btnFavorite.isHidden = mv.deleteButtonIsHiddenStatus
        
        //Cars List
        switchFavorite.tag = mv.index
        switchFavorite.addTarget(self, action: #selector(onValueChanged), for: UIControlEvents.valueChanged)
        switchFavorite.setOn(mv.checkFavoriteStatus(), animated: false)
        switchFavorite.isEnabled = mv.favoriteSwitchIsEnabledStatus
        
        //Favorites
        btnFavorite.tag = mv.index
        btnFavorite.addTarget(self, action: #selector(deleteVehicle), for: UIControlEvents.touchUpInside)
        
    }
    
    // MARK:- IBActions Methods
    func onValueChanged(sender: UISwitch) {
        mv.processFavoritesAt( )
        mv.sendFavoritesStatusLocalNotification(status: sender.isOn )
        
    }
    // MARK:- IBActions Methods
    func deleteVehicle(sender: UIButton) {
        mv.processFavoritesAt( )
        mv.sendReloadDataStatusLocalNotification(isShowActivityIndicator: true)
    }
    
}
