//
//  ItemListActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/1/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ItemListActivity: UIViewController, UITableViewDataSource {
    private static var data:[String] = []
    private static var beforeData:[Item] = []
    @IBOutlet weak var tableView: UITableView!
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        ItemListActivity.data = MainPageActivity.getData()
        
        
        tableView.dataSource = self
        
        //ItemListActivity.data.append("test")
        
        //readData()
        
        //ItemListActivity.beforeData = AddItemActivity.getData()
        
//        for item in ItemListActivity.beforeData {
//            ItemListActivity.data.append(item.getName())
//        }
        
        //tableView.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemListActivity.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier2")! //1.
        
        let text = ItemListActivity.data[indexPath.row] //2.
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
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
                    ItemListActivity.data.append(name)
                }
            }
        }
        
    }
    

}
