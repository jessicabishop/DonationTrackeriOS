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
    static var data:[String] = []
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
                    let name = document.get("name") as! String
                    
                    print(name)
                    MainPageActivity.data.append(name)
                }
            }
        }
        
    }
    
    static func getData() -> [String] {
        return MainPageActivity.data
    }
    
    static func addData(name:String) {
        MainPageActivity.data.append(name)
    }

}
