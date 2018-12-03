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
    
    
    @IBAction func onLoginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextFieldL.text!, password: passwordTextFieldL.text!) { (user, error) in
            if error != nil {
                print(error!)
                self.showToast(message: "Incorrect email or password")
                
            } else {
                print("Login successful")
                
                self.showToast(message: "Login Successful")
                self.performSegue(withIdentifier: "fromLoginToMainPage", sender: self)
            }
        }
        
    }
        
    
}
