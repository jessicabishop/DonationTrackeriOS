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

class ItemListActivity: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    private static var itemData:[Item] = []
    private static var data:[Item] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonRef: UIButton!
    var db: Firestore!
    @IBOutlet weak var searchTypeSpinner: UIPickerView!
    static var currentLocation: Int = -1
    static var searchMethod: String = ""
    static var itemSelected = Item(name: "", cost: "", shortDescription: "", longDescription: "", locationID: "", itemType: "", date: "")
    static var legalSearchItems: [String] = [String]()
    //ItemListActivity.data[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        buttonRef.layer.cornerRadius = 10
        buttonRef.clipsToBounds = true
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchTypeSpinner.delegate = self
        self.searchTypeSpinner.dataSource = self
        
        ItemListActivity.data = []
        
        ItemListActivity.currentLocation = NavigateToItemListActivity.getLocationSelected()
        
        ItemListActivity.itemData = MainPageActivity.getData()
        
        ItemListActivity.searchMethod = NavigateToItemListActivity.getSearchType()
        
        print(ItemListActivity.searchMethod)
        
        print(ItemListActivity.currentLocation)
        
        if (ItemListActivity.searchMethod == "None") { //displays normally, gets rid of button
            ItemListActivity.legalSearchItems = []
            buttonRef.isHidden = true
            if (ItemListActivity.currentLocation == 0) {
                ItemListActivity.data = ItemListActivity.itemData
            } else {
                for item in ItemListActivity.itemData {
                    let itemLocID: Int = Int(item.getLocationID())!
                    if (itemLocID == ItemListActivity.currentLocation) {
                        print(itemLocID)
                        ItemListActivity.data.append(item)
                    }
                }
            }
        } else if (ItemListActivity.searchMethod == "By Name") { //doesn't display yet, have to press button by name
            for item in ItemListActivity.itemData {
                ItemListActivity.legalSearchItems.append(item.getName())
            }
        } else if (ItemListActivity.searchMethod == "By Item Type") { //doesn't display yet, have to press button by item type
            ItemListActivity.legalSearchItems = ["Furniture", "Clothes", "Shoes", "Food", "Sports", "Electronics", "Misc"]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ItemListActivity.legalSearchItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ItemListActivity.legalSearchItems[row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemListActivity.data.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(ItemListActivity.data[indexPath.row].getName())
        ItemListActivity.itemSelected = ItemListActivity.data[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier2")! //1.
        
        let text = ItemListActivity.data[indexPath.row] //2.
        ItemListActivity.itemSelected = ItemListActivity.data[indexPath.row]
        
        cell.textLabel?.text = text.getName() //3.
        
        return cell //4.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    static func getItemSelected() -> Item {
        return ItemListActivity.itemSelected
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        tableView.reloadData()
    }
    
    @IBAction func onSearchItemButtonPressed(_ sender: Any) {
        ItemListActivity.data = []
        if (ItemListActivity.searchMethod == "By Name") {
            print("ByName")
            if (ItemListActivity.currentLocation == 0) {
                for item in ItemListActivity.itemData {
                    if (item.getName() == ItemListActivity.legalSearchItems[searchTypeSpinner.selectedRow(inComponent: 0)]) {
                        print("\(item.getName())")
                        print("\(ItemListActivity.legalSearchItems[searchTypeSpinner.selectedRow(inComponent: 0)])")
                        ItemListActivity.data.append(item)
                    }
                }
            } else {
                for item in ItemListActivity.itemData {
                    let itemLocID: Int = Int(item.getLocationID())!
                    if ((itemLocID == ItemListActivity.currentLocation) && (item.getName() == ItemListActivity.legalSearchItems[searchTypeSpinner.selectedRow(inComponent: 0)])) {
                        print(itemLocID)
                        ItemListActivity.data.append(item)
                    }
                }
            }
            self.tableView.reloadData()
        } else if (ItemListActivity.searchMethod == "By Item Type") {
            print("ByItemType")
            if (ItemListActivity.currentLocation == 0) {
                for item in ItemListActivity.itemData {
                    if (item.getItemType() == ItemListActivity.legalSearchItems[searchTypeSpinner.selectedRow(inComponent: 0)]) {
                        print("\(item.getItemType())")
                        print("\(ItemListActivity.legalSearchItems[searchTypeSpinner.selectedRow(inComponent: 0)])")
                        ItemListActivity.data.append(item)
                    }
                }
            } else {
                for item in ItemListActivity.itemData {
                    let itemLocID: Int = Int(item.getLocationID())!
                    if ((itemLocID == ItemListActivity.currentLocation) && item.getItemType() == ItemListActivity.legalSearchItems[searchTypeSpinner.selectedRow(inComponent: 0)]) {
                        print(itemLocID)
                        ItemListActivity.data.append(item)
                    }
                }
            }
            self.tableView.reloadData()
        }
        
    }
}
