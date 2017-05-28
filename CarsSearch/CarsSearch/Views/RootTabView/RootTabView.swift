//
//  RootTabView.swift
//  CarsSearch
//
//  Created by Yahia Work on 5/28/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RootTabView:UITabBarController{
    let mv:RootTabViewModel = RootTabViewModel();
    
    override func viewDidLoad() {
        _ =  mv.badge.asObservable()
            .subscribe(onNext: { n in
                if(n.characters.count>0){
                    self.viewControllers?[1].tabBarItem.badgeValue = n
                }else{
                    self.viewControllers?[1].tabBarItem.badgeValue = nil
                }
            }, onCompleted: {
                print("Completed 1")
            })
        
        
    }
}
