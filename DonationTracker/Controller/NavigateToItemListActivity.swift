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
    var legalLocationTypes: [String] = [String]()
    static var locSelected: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
        
        legalLocationTypes = ["AFD Station 4", "Boys & Girls Club W.W. Woolfolk", "Pathway Upper Room Christian Ministries", "Pavilion of Hope Inc", "D&D Convenience Store", "Keep North Fulton Beautiful"]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return legalLocationTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return legalLocationTypes[row]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSeeItem(_ sender: Any) {
        var locationSelected = legalLocationTypes[locationPicker.selectedRow(inComponent: 0)]
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
        
        NavigateToItemListActivity.locSelected = locationID
    }
    
    static func getLocationSelected() -> Int {
        return NavigateToItemListActivity.locSelected
    }
}
