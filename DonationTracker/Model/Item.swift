//
//  Item.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/1/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation

class Item {
    var name:String;
    var cost:String;
    var shortDescription:String;
    var longDescription:String;
    var locationID:String;
    var itemType:String;
    var date:String;
    
    init(name: String, cost: String, shortDescription:String, longDescription:String, locationID:String, itemType: String, date: String) {
        self.name = name
        self.cost = cost
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.locationID = locationID
        self.itemType = itemType
        self.date = date
    }
    
    func getName() -> String {
        return name
    }
    
    func getLocationID() -> String {
        return locationID
    }
    
    func getItemType() -> String {
        return itemType
    }
    
    func getCost() -> String {
        return cost
    }
    
}
