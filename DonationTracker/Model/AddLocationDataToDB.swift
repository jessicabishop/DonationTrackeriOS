//
//  AddLocationDataToDB.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/26/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import Firebase

class AddLocationDataToDB {
    func addLocDataFromCSV() {
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
        print(contents)
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        let db = Firestore.firestore()
        
        var locationData: [[String]] = parseCsv(contents)
        let dataHeader = locationData.removeFirst()
        var j = 0
        while (j < locationData.count) {
            db.collection("locations").document(String(j)).setData([
                "locationID": locationData[j][0],
                "locationName": locationData[j][1],
                "latitude": locationData[j][2],
                "longitude": locationData[j][3],
                "streetAddress": locationData[j][4],
                "city": locationData[j][5],
                "state": locationData[j][6],
                "zip": locationData[j][7],
                "type": locationData[j][8],
                "phone": locationData[j][9],
                "website": locationData[j][10]
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successully written!")
                }
            }
            j = j + 1
        }
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
