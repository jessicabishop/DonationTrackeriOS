//
//  ResetPasswordActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/3/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ResetPasswordActivity: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //this is a test
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
    
    @IBAction func buttonPressed(_ sender: Any) {
        let emailEntered:String = emailTextField.text!
        Auth.auth().sendPasswordReset(withEmail: emailEntered) { (error) in
            if error != nil {
                print(error!)
                self.showToast(message: "Email does not exist")
                
            } else {
                print("Email has been sent")
                
                self.showToast(message: "Email has been sent")
                DispatchQueue.main.asyncAfter(deadline:.now() + 0.5, execute: {
                    self.performSegue(withIdentifier: "resetToWelcome", sender: self)
                })
            }
        }
    }
    
}
