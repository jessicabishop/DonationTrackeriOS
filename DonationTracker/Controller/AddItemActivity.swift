//
//  AddItemActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/26/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddItemActivity: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var shortDescriptionTextField: UITextField!
    @IBOutlet weak var longDescriptionTextField: UITextField!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var itemTypePicker: UIPickerView!
    var legalLocationTypes: [String] = [String]()
    var legalItemTypes: [String] = [String]()
    static var data: [Item] = []
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
        self.itemTypePicker.delegate = self
        self.itemTypePicker.dataSource = self
        
        
        
        legalLocationTypes = ["AFD Station 4", "Boys & Girls Club W.W. Woolfolk", "Pathway Upper Room Christian Ministries", "Pavilion of Hope Inc", "D&D Convenience Store", "Keep North Fulton Beautiful"]
        
        legalItemTypes = ["Furniture", "Clothes", "Shoes", "Food", "Sports", "Electronics", "Misc"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == locationPicker) {
            return legalLocationTypes.count
        } else if (pickerView == itemTypePicker) {
            return legalItemTypes.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == locationPicker) {
            return legalLocationTypes[row]
        } else if (pickerView == itemTypePicker) {
            return legalItemTypes[row]
        } else {
            return ""
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onAddItem(_ sender: Any) {
        let currentDateTime = Date()
        
        let userCalendar = Calendar.current
        
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        let year:Int = dateTimeComponents.year!
        let month:Int = dateTimeComponents.month!
        let day:Int = dateTimeComponents.day!
        let hour:Int = dateTimeComponents.hour!
        let minute:Int = dateTimeComponents.minute!
        let second:Int = dateTimeComponents.second!
//        print(year)
//        print(month)
//        print(day)
//        print(hour)
//        print(minute)
//        print(second)
        print("\(month)/\(day)/\(year) \(hour):\(minute):\(second)")
        
        let locationSelected = legalLocationTypes[locationPicker.selectedRow(inComponent: 0)]
        let itemTypeSelected = legalItemTypes[itemTypePicker.selectedRow(inComponent: 0)]
        var locationID = 0
        switch locationSelected {
        case "AFD Station 4":
            locationID = 1
        case "Boys & Girls Club W.W. Woolfolk":
            locationID = 2
        case "Pathway Uppser Room Christian Ministries":
            locationID = 3
        case "Pavilion of Hope Inc":
            locationID = 4
        case "D&D Convenience Store":
            locationID = 5
        case "Keep North Fulton Beautiful":
            locationID = 6
        default:
            locationID = 0;
        }
        
        print(locationID)
        print(itemTypeSelected)
        
        if (itemNameTextField.text! != nil && costTextField != nil) {
            db.collection("items").document(itemNameTextField.text!).setData([
                "name" : itemNameTextField.text!,
                "cost" : costTextField.text!,
                "shortDescription" : shortDescriptionTextField.text!,
                "longDescription" : longDescriptionTextField.text!,
                "locationID" : locationID,
                "itemType" : itemTypeSelected,
                "date" : "\(month)/\(day)/\(year) \(hour):\(minute):\(second)"
                ])
        }
        
        MainPageActivity.addData(item: Item(name: itemNameTextField.text!, cost: costTextField.text!, shortDescription: shortDescriptionTextField.text!, longDescription: longDescriptionTextField.text!, locationID: String(locationID), itemType: itemTypeSelected, date: "\(month)/\(day)/\(year) \(hour):\(minute):\(second)"))
        
        print("Added item")
    }
    
    static func getData() -> [Item] {
        return AddItemActivity.data
    }
}

