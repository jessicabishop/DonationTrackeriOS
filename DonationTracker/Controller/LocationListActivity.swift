//
//  LocationListActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/26/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LocationListActivity: UIViewController, UITableViewDataSource {
    private var data: [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let settings = FirestoreSettings()
//        Firestore.firestore().settings = settings
        
//        var db = Firestore.firestore()
//        let locationsRef = db.collection("locations").document("1")
//        print(locationsRef)
//        let loc1 = locationsRef.whereField("locationID", isEqualTo: 1)
//        print(loc1.)
//        data.append("\(loc1)")
//        let loc2 = locationsRef.whereField("locationID", isEqualTo: 2)
//        data.append("\(loc2)")
        
        var contents = ""
        guard let filePath = Bundle.main.path(forResource: "LocationData", ofType: "csv")
            else {
                return
        }
        do {
            contents = try String(contentsOfFile: filePath, encoding: .utf8)
            
        } catch {
            print("File read error for file \(filePath)")
        }
        var locationData: [[String]] = parseCsv(contents)
        let dataHeader = locationData.removeFirst()
        
        var j = 0
        while (j < locationData.count) {
            data.append("\(locationData[j][1])")
            j = j + 1
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! //1.
        
        let text = data[indexPath.row] //2.
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
    }
    
    func parseCsv(_ data: String) -> [[String]] {
        // data: String = contents of a CSV file.
        // Returns: [[String]] = two-dimension array [rows][columns].
        // Data minimum two characters or fail.
        if data.count < 2 {
            return []
        }
        var a: [String] = [] // Array of columns.
        var index: String.Index = data.startIndex
        let maxIndex: String.Index = data.index(before: data.endIndex)
        var q: Bool = false // "Are we in quotes?"
        var result: [[String]] = []
        var v: String = "" // Column value.
        while index < data.endIndex {
            if q { // In quotes.
                if (data[index] == "\"") {
                    // Found quote; look ahead for another.
                    if index < maxIndex && data[data.index(after: index)] == "\"" {
                        // Found another quote means escaped.
                        // Increment and add to column value.
                        data.formIndex(after: &index)
                        v += String(data[index])
                    } else {
                        // Next character not a quote; last quote not escaped.
                        q = !q // Toggle "Are we in quotes?"
                    }
                } else {
                    // Add character to column value.
                    v += String(data[index])
                }
            } else { // Not in quotes.
                if data[index] == "\"" {
                    // Found quote.
                    q = !q // Toggle "Are we in quotes?"
                } else if data[index] == "\r" || data[index] == "\r\n" {
                    // Reached end of line.
                    // Column and row complete.
                    a.append(v)
                    v = ""
                    result.append(a)
                    a = []
                } else if data[index] == "," {
                    // Found comma; column complete.
                    a.append(v)
                    v = ""
                } else {
                    // Add character to column value.
                    v += String(data[index])
                }
            }
            if index == maxIndex {
                // Reached end of data; flush.
                if v.count > 0 || data[data.index(before: index)] == "," {
                    a.append(v)
                }
                if a.count > 0 {
                    result.append(a)
                }
                break
            }
            data.formIndex(after: &index) // Increment.
        }
        return result
    }
}
