//
//  LoginViewController.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 11/24/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextFieldL: UITextField!
    @IBOutlet weak var passwordTextFieldL: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginButtonPressed(_ sender: Any) {
       // SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextFieldL.text!, password: passwordTextFieldL.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Login successful")
                
                //SVProgressHUD.dismiss()
                //self.performSegue(withIdentifier: "toMainPageFromLogin", sender: self)
            }
        }
    }
        
    
}
