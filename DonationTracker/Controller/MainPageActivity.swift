//
//  MainPageActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/23/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MainPageActivity: UIViewController {
    static var data:[Item] = []
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        MainPageActivity.data = []
        readData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func readData() {
        //var testing:[String] = []
        self.db.collection("items").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let name1 = document.get("name") as! String
                    let cost1 = document.get("cost") as! String
                    let shortDescription1 = document.get("shortDescription") as! String
                    let longDescription1 = document.get("longDescription") as! String
                    let locationID1 = document.get("locationID") as! Int
                    let itemType1 = document.get("itemType") as! String
                    let date1 = document.get("date") as! String
                    
                    print(name1)
                    MainPageActivity.data.append(Item(name: name1, cost: cost1, shortDescription: shortDescription1, longDescription: longDescription1, locationID: String(locationID1), itemType: itemType1, date: date1))
                }
            }
        }
        
    }
    
    static func getData() -> [Item] {
        return MainPageActivity.data
    }
    
    static func addData(item:Item) {
        MainPageActivity.data.append(item)
    }

}
