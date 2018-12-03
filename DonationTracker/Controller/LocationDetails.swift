//
//  LocationDetails.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/2/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit

class LocationDetails: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationIDLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        let locationDisplayed = LocationListActivity.getCurrentLocation();
        
        if (locationDisplayed == "AFD Station 4") {
            self.nameLabel.text! = "AFD Station 4"
            self.locationIDLabel.text! = "1"
            self.phoneNumberLabel.text! = "(404) 555 - 3456"
            self.addressLabel.text! = "309 Edgewood Ave SE"
            self.cityLabel.text! = "Atlanta"
            self.stateLabel.text! = "Georgia"
            self.zipLabel.text! = "30332"
            self.websiteLabel.text! = "www.afd04.atl.ga"
            self.typeLabel.text! = "Drop off"
        } else if (locationDisplayed == "BOYS & GILRS CLUB W.W. WOOLFOLK") {
            self.nameLabel.text! = "Boys & Girls Club W.W. Woolfolk"
            self.locationIDLabel.text! = "2"
            self.phoneNumberLabel.text! = "(404) 555 - 1234"
            self.addressLabel.text! = "1642 Richland Rd"
            self.cityLabel.text! = "Atlanta"
            self.stateLabel.text! = "Georgia"
            self.zipLabel.text! = "30332"
            self.websiteLabel.text! = "www.bgc.wool.ga"
            self.typeLabel.text! = "Store"
        } else if (locationDisplayed == "PATHWAY UPPER ROOM CHRISTIAN MINISTRIES") {
            self.nameLabel.text! = "Pathway Upper Room Christian Ministries"
            self.locationIDLabel.text! = "3"
            self.phoneNumberLabel.text! = "(404) 555 - 5432"
            self.addressLabel.text! = "1683 Sylvan Rd"
            self.cityLabel.text! = "Atlanta"
            self.stateLabel.text! = "Georgia"
            self.zipLabel.text! = "30332"
            self.websiteLabel.text! = "www.pathways.org"
            self.typeLabel.text! = "Warehouse"
        } else if (locationDisplayed == "PAVILION OF HOPE INC") {
            self.nameLabel.text! = "Pavilion of Hope Inc"
            self.locationIDLabel.text! = "4"
            self.phoneNumberLabel.text! = "(404) 555 - 8765"
            self.addressLabel.text! = "3558 East Ponce De Leon Ave"
            self.cityLabel.text! = "Scottdale"
            self.stateLabel.text! = "Georgia"
            self.zipLabel.text! = "30779"
            self.websiteLabel.text! = "www.pavhope.org"
            self.typeLabel.text! = "Warehouse"
        } else if (locationDisplayed == "D&D CONVENIENCE STORE") {
            self.nameLabel.text! = "D&D Convenience Store"
            self.locationIDLabel.text! = "5"
            self.phoneNumberLabel.text! = "(404) 555 - 9876"
            self.addressLabel.text! = "2426 Columbia Drive"
            self.cityLabel.text! = "Decatur"
            self.stateLabel.text! = "Georgia"
            self.zipLabel.text! = "30334"
            self.websiteLabel.text! = "www.ddconv.com"
            self.typeLabel.text! = "Drop Off"
        } else if (locationDisplayed == "KEEP NORTH FULTON BEAUTIFUL") {
            self.nameLabel.text! = "Keep North Fulton Beautiful"
            self.locationIDLabel.text! = "6"
            self.phoneNumberLabel.text! = "(404) 555 - 9876"
            self.addressLabel.text! = "470 Morgan Falls Rd"
            self.cityLabel.text! = "Springs"
            self.stateLabel.text! = "Georgia"
            self.zipLabel.text! = "30302"
            self.websiteLabel.text! = "www.knfb.org"
            self.typeLabel.text! = "Store"
        } else {
            self.nameLabel.text! = ""
            self.locationIDLabel.text! = ""
            self.phoneNumberLabel.text! = ""
            self.addressLabel.text! = ""
            self.cityLabel.text! = ""
            self.stateLabel.text! = ""
            self.zipLabel.text! = ""
            self.websiteLabel.text! = ""
            self.typeLabel.text! = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
