//
//  DataReposetory.swift
//  CarsSearch
//
//  Created by Yahia Work on 6/13/17.
//  Copyright © 2017 Yahia. All rights reserved.
//

import Foundation

enum DataSources {
    case Online
    case DB
}

class DataReposetory :NSObject  {
    
    //Variables
    private var dataSourceType: DataSources?
    private var dataSource: DataAccessControllerInterface?
    
    private var onlineController:OnlineController!
    private var dbController:DBController!
    
    override init() {
        super.init();
        onlineController = OnlineController()
        dbController = DBController()
        
        setNewDataSource(source: .Online)
    }
    func getDataSource()->DataAccessControllerInterface{
        return self.dataSource!;
    }
    
    func dataSourceForType(source: DataSources) -> DataAccessControllerInterface?{
        switch source {
        case DataSources.Online:
            return onlineController
        case DataSources.DB:
            return dbController
        }
    }
    
    func setNewDataSource(source: DataSources) {
        self.dataSourceType = source
        self.dataSource = dataSourceForType(source: source)
    }
}
