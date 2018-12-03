//
//  NavigateToItemListActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/1/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit

class NavigateToItemListActivity: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var searchTypePicker: UIPickerView!
    var legalSearchTypes: [String] = [String]()
    var legalLocationTypes: [String] = [String]()
    static var locSelected: Int = -1
    static var searchType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
        self.searchTypePicker.delegate = self
        self.searchTypePicker.dataSource = self
        
        legalLocationTypes = ["All Locations", "AFD Station 4", "Boys & Girls Club W.W. Woolfolk", "Pathway Upper Room Christian Ministries", "Pavilion of Hope Inc", "D&D Convenience Store", "Keep North Fulton Beautiful"]
        legalSearchTypes = ["None", "By Name", "By Item Type"]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == locationPicker) {
            return legalLocationTypes.count
        } else if (pickerView == searchTypePicker) {
            return legalSearchTypes.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == locationPicker) {
            return legalLocationTypes[row]
        } else if (pickerView == searchTypePicker) {
            return legalSearchTypes[row]
        } else {
            return ""
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSeeItem(_ sender: Any) {
        let locationSelected = legalLocationTypes[locationPicker.selectedRow(inComponent: 0)]
        var locationID: Int = 0
        switch locationSelected {
        case "AFD Station 4":
            locationID = 1
        case "Boys & Girls Club W.W. Woolfolk":
            locationID = 2
        case "Pathway Upper Room Christian Ministries":
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
        
        NavigateToItemListActivity.searchType = legalSearchTypes[searchTypePicker.selectedRow(inComponent: 0)]
        NavigateToItemListActivity.locSelected = locationID
    }
    
    static func getLocationSelected() -> Int {
        return NavigateToItemListActivity.locSelected
    }
    
    static func getSearchType() -> String {
        return NavigateToItemListActivity.searchType
    }
}
