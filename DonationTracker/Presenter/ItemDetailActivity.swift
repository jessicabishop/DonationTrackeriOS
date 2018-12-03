//
//  ItemDetailActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/2/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ItemDetailActivity: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var itemTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateAddedLabel: UILabel!
    static var itemSelected = ItemListActivity.getItemSelected()
    var db: Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        ItemDetailActivity.itemSelected = ItemListActivity.getItemSelected()
        print(ItemDetailActivity.itemSelected.getName())
        
        self.nameLabel.text = ItemDetailActivity.itemSelected.getName()
        self.costLabel.text = ItemDetailActivity.itemSelected.getCost()
        self.shortDescriptionLabel.text = ItemDetailActivity.itemSelected.getShortDescription()
        self.longDescriptionLabel.text = ItemDetailActivity.itemSelected.getLongDescription()
        self.itemTypeLabel.text = ItemDetailActivity.itemSelected.getItemType()
        
        let locationID = Int(ItemDetailActivity.itemSelected.getLocationID())
        var locationName = ""
        switch locationID {
        case 1:
            locationName = "AFD Station 4"
        case 2:
            locationName = "Boys & Girls Club W.W. Woolfolk"
        case 3:
            locationName = "Pathway Uppser Room Christian Ministries"
        case 4:
            locationName = "Pavilion of Hope Inc"
        case 5:
            locationName = "D&D Convenience Store"
        case 6:
            locationName = "Keep North Fulton Beautiful"
        default:
            locationName = "";
        }
        
        self.locationLabel.text = locationName
        self.dateAddedLabel.text = ItemDetailActivity.itemSelected.getDate()
        
        
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 140, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    static func getItemSelected() -> Item {
        return ItemDetailActivity.itemSelected
    }

    @IBAction func onDeleteItem(_ sender: Any) {
        let itemBeingDeleted = ItemDetailActivity.getItemSelected()
        print(itemBeingDeleted.getName())
        
        let itemBeingDeletedName = itemBeingDeleted.getName()
        
        let documentRef = db.collection("items").document(itemBeingDeletedName)
        //maybe add new method to delete from array
        //var itemToDeleteInArray = MainPageActivity.findItem(item: itemBeingDeleted)
        documentRef.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                self.showToast(message: "Item Delete Failed")
            } else {
                print("Document successfully removed!")
                
            }
        }
        
        var wasDeletedByArray = MainPageActivity.deleteItem(item: itemBeingDeleted)
        
        if (wasDeletedByArray) {
            print("Successfully deleted from array")
            self.showToast(message: "Item deleted")
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.5, execute: {
                self.performSegue(withIdentifier: "deleteToList", sender: self)
            })
        } else {
            print("Did not remove from array")
        }
        
        
    }
}
