//
//  RegisterViewController.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/24/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var emailTextFieldR: UITextField!
    @IBOutlet var passwordTextFieldR: UITextField!
    @IBOutlet weak var userTypePickerView: UIPickerView!
    var legalUserTypes: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTypePickerView.delegate = self
        self.userTypePickerView.dataSource = self
        
        
        legalUserTypes = ["Donator", "Volunteer", "Manager", "Admin"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return legalUserTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return legalUserTypes[row]
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
    
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
            //SVProgressHUD.show()
        
            Auth.auth().createUser(withEmail: emailTextFieldR.text!, password: passwordTextFieldR.text!) { (user, error) in
                
                if error != nil {
                    print(error!)
                    self.showToast(message: "Registration failed")
                } else {
                    print("Registration complete")
                    
                    let selected = self.legalUserTypes[self.userTypePickerView.selectedRow(inComponent: 0)]
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = String(selected)
                    changeRequest?.commitChanges(completion: { (error) in
                        if error != nil {
                            print(error!)
                            
                        } else {
                            print("Change Successful")
                            let user = Auth.auth().currentUser
                            if let user = user {
                                let type = user.displayName
                                print(type)
                            }
                        }
                    })
                    self.showToast(message: "Registration Successful")
                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.5, execute: {
                        self.performSegue(withIdentifier: "registrationToMain", sender: self)
                    })
                    
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        if error != nil {
                            print(error!)
                        } else {
                            print("Sending email")
                        }
                    }
                    
                    //SVProgressHUD.dismiss()
                    
                    //self.performSegue(withIdentifier: "toMainPageFromRegistration", sender: self)
                }
            }
    }
    
}
