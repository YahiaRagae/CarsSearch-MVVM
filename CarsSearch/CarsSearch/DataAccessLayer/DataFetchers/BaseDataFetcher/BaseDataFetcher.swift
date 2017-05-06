//
//  BaseDataFetcher.swift
//  CarsSearch
//
//  Created by Yahia on 5/5/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
open class  BaseDataFetcher: NSObject{
    static let SETTINGS_MAIN_URL:String = "MainURL"
    static let SETTINGS_URLs:String = "URLs"
    
    var sessionManager:SessionManager!

    open func getRequestWithJsonReponse( withLink link:String ,    andCompletion  completion:  (( _ response : DataResponse<Any>, _ status : Bool )->Void)? ){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if(sessionManager == nil ){
            let configuration = URLSessionConfiguration.default 
            sessionManager = Alamofire.SessionManager(
                configuration: configuration 
            )
        }
        
        sessionManager.request(link, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        .validate()
        .responseJSON { (response) in
            
            switch response.result {
            case .success:
                completion?(response , true)
            case .failure:
                completion?(response , false)

            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

         }
    }
    
    
    
   open  func getSettingdDictionary() ->NSDictionary!
    {
        if let path = Bundle.main.path(forResource: "Settings", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }
    
   open func getLink(_ endPointName:String) ->String{
        var link = "";
        
        let settingsDic:NSDictionary = getSettingdDictionary();
        
        let urls:NSDictionary = settingsDic.object(forKey: BaseDataFetcher.SETTINGS_URLs) as! NSDictionary
        
        link = (settingsDic.object(forKey: BaseDataFetcher.SETTINGS_MAIN_URL) as! String) +  (urls.object(forKey: endPointName) as! String)
        
        return link;
    }
    open func getMainLink() ->String{
        var link = "";
        let settingsDic:NSDictionary = getSettingdDictionary();
        link = (settingsDic.object(forKey: BaseDataFetcher.SETTINGS_MAIN_URL) as! String)
        
        return link;
    }

}
