//
//  User.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/23/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation

class User {
    var firstName:String;
    var lastName:String;
    var email:String;
    var password:String;
    var userType:UserType;
    
    init(firstName:String, lastName:String, email:String, password:String, userTypeStr:String) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
        self.password = password;
        self.userType = UserType.Donator;
        let temp = strToUserType(str: userTypeStr);
        self.userType = temp;
    }
    
    func strToUserType(str:String) -> UserType {
        switch str {
        case "Donator":
            return UserType.Donator
        case "Volunteer":
            return UserType.Volunteer
        case "Manger":
            return UserType.Manager
        case "Admin":
            return UserType.Admin
        case "Guest":
            return UserType.Guest
        default:
            return UserType.Guest;
        }
    }
    
    func getEmail() -> String {
        return email;
    }
    
    func getFirstName() -> String {
        return firstName;
    }
    
    func getLastName() -> String {
        return lastName;
    }
    
    func getUserType() -> UserType {
        return userType;
    }
    
    func getPassword() -> String {
        return password;
    }
}
