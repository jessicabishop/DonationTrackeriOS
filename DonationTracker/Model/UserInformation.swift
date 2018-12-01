//
//  UserInformation.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/23/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation

class UserInformation {
    static var users = [String : User]()
    
    init(defaultFirstName:String, defaultLastName:String, defaultEmail:String, defaultPassword:String) {
        var newUser = User(firstName: defaultFirstName, lastName: defaultLastName, email: defaultEmail, password: defaultPassword, userTypeStr: "Donator");
        UserInformation.users[defaultEmail] = newUser;
    }
    
    static func getUser() -> Dictionary<String, User> {
        return users;
    }
    
    static func addUser(firstNameN:String, lastNameN:String, emailN:String, passwordN:String) -> Bool {
        var temp = User(firstName: firstNameN, lastName: lastNameN, email: emailN, password: passwordN, userTypeStr: "Donator");
        users[emailN] = temp;
        return true;
    }
    
    static func signInUser(emailIn:String, passwordIn:String) -> Bool{
        if (users.keys.contains(emailIn)) {
            let theUserSigningIn = users[emailIn];
            if (theUserSigningIn?.getPassword() == passwordIn) {
                //Set singleton
                print("Signed in");
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
}
