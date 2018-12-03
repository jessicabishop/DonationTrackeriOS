//
//  Item.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/1/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation

class Item {
    private var name:String;
    private var cost:String;
    private var shortDescription:String;
    private var longDescription:String;
    private var locationID:String;
    private var itemType:String;
    private var date:String;
    
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
    
    func getShortDescription() -> String {
        return shortDescription
    }
    
    func getLongDescription() -> String {
        return longDescription
    }
    
    func getDate() -> String {
        return date
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setCost(cost: String) {
        self.cost = cost
    }
    
    func setShortDescription(shortDescription: String) {
        self.shortDescription = shortDescription
    }
    
    func setLongDescription(longDescription: String) {
        self.longDescription = longDescription
    }
    
    func setLocationID(locationID: String) {
        self.locationID = locationID
    }
    
    func setItemType(itemType: String) {
        self.itemType = itemType
    }
    
}
