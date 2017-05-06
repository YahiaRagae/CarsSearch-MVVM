//
//  AysncLoadImage+UIImageView.swift
//  CarsSearch
//
//  Created by Yahia on 5/6/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import Alamofire
import  AlamofireImage
extension UIImageView {
    public func imageFromUrl(urlString: String) {
        
        
        let imageCached = DataAccessController.sharedInstance.imageCache.image(withIdentifier: urlString)
        if(imageCached != nil ){
            self.image = imageCached
        }else{
            Alamofire.request(urlString).responseImage { response in
                if let image = response.result.value {
                    self.image = image
                    DataAccessController.sharedInstance.imageCache.add(image, withIdentifier: urlString)
                }
            }
        }
        
        
    }
}
