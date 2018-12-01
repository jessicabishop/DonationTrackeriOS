//
//  Location.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/26/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation

class Location {
    var locationID:String;
    var locationName:String;
    var latitude:String;
    var longitude:String;
    var streetAddress:String;
    var city:String;
    var state:String;
    var zip:String;
    var type:String;
    var phone:String;
    var website:String;
    
    init(locationID: String, locationName: String, latitude: String, longitude: String, streetAddress: String, city: String, state: String, zip:String, type: String, phone: String, website: String) {
        self.locationID = locationID
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.type = type
        self.phone = phone
        self.website = website
    }
    
    func getLocationID() -> String {
        return locationID
    }
    
}
