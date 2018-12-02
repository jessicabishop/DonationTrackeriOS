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

class ItemListActivity: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private static var itemData:[Item] = []
    private static var data:[String] = []
    @IBOutlet weak var tableView: UITableView!
    var db: Firestore!
    static var currentLocation: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        ItemListActivity.data = []
        
        ItemListActivity.currentLocation = NavigateToItemListActivity.getLocationSelected()
        
        ItemListActivity.itemData = MainPageActivity.getData()
        
        print(ItemListActivity.currentLocation)
        
        for item in ItemListActivity.itemData {
            var itemLocID: Int = Int(item.getLocationID())!
            if (itemLocID == ItemListActivity.currentLocation) {
                print(itemLocID)
                ItemListActivity.data.append("Item name: \(item.getName()), ItemType: \(item.getItemType()), Cost: \(item.getCost())")
            }
        }
        
        
        
        
        tableView.dataSource = self
        
        
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier2")! //1.
        
        let text = ItemListActivity.data[indexPath.row] //2.
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
    }
    

}
