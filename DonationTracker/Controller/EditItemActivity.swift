//
//  EditItemActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/2/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class EditItemActivity: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var shortDescriptionField: UITextField!
    @IBOutlet weak var longDescriptionField: UITextField!
    @IBOutlet weak var itemTypePicker: UIPickerView!
    @IBOutlet weak var locationPicker: UIPickerView!
    var legalLocationTypes: [String] = [String]()
    var legalItemTypes: [String] = [String]()
    var db: Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.hidesBackButton = true
        
        //instantiate firestore
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        //add data source and delegates to pickers
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
        self.itemTypePicker.delegate = self
        self.itemTypePicker.dataSource = self
        
        //add picker values
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
    
    @IBAction func onMakeChanges(_ sender: Any) {
        
        //item being changed
        let itemBeingChanged = ItemDetailActivity.getItemSelected()
        print(itemBeingChanged.getName())
        
        //getting location selected by locationPicker
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
        
        //name of current item in database before change
        let itemBeingChangedName = itemBeingChanged.getName()
        
        //getting database reference
        let documentRef = db.collection("items").document(itemBeingChangedName)
        var itemToChangeInArray = MainPageActivity.findItem(item: itemBeingChanged)
        
        //setting different fields if they aren't blank
        if (!(nameField.text!.isEmpty)) {
            documentRef.updateData([
                "name": nameField.text!
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated: Name")
                }
            }
            itemToChangeInArray.setName(name: nameField.text!)
            print("name array changed")
        }
        
        //setting cost
        if (!(costField.text!.isEmpty)) {
            documentRef.updateData([
                "cost": costField.text!
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated: Cost")
                }
            }
            itemToChangeInArray.setCost(cost: costField.text!)
            print("cost array changed")
        }
        
        //setting short description
        if (!(shortDescriptionField.text!.isEmpty)) {
            documentRef.updateData([
                "shortDescription": shortDescriptionField.text!
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated: Short Description")
                }
            }
            itemToChangeInArray.setShortDescription(shortDescription: shortDescriptionField.text!)
            print("short array changed")
        }
        
        //setting long description
        if (!(longDescriptionField.text!.isEmpty)) {
            documentRef.updateData([
                "longDescription": longDescriptionField.text!
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated: Long Description")
                }
            }
            itemToChangeInArray.setLongDescription(longDescription: longDescriptionField.text!)
            print("long array changed")
            print(itemToChangeInArray.getShortDescription())
        }
        
        //setting locationID and itemType
        documentRef.updateData([
            "locationID": locationID,
            "itemType": itemTypeSelected
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated: Name")
            }
        }
        
        //setting locID and itemType in array
        itemToChangeInArray.setLocationID(locationID: String(locationID))
        print("locationId array chagned")
        itemToChangeInArray.setItemType(itemType: itemTypeSelected)
        print("itemType array chnged")
        
        print("\(itemToChangeInArray.getName()) \(itemToChangeInArray.getCost()) \(itemToChangeInArray.getShortDescription()) \(itemToChangeInArray.getLongDescription()) \(itemToChangeInArray.getLocationID()) \(itemToChangeInArray.getItemType())")
    }
}
