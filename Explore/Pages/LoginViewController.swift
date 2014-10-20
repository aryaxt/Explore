//
//  LoginViewController.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class LoginViewController: BaseViewController {
    
    lazy var authService = AuthenticationService()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        if (PFUser.currentUser() != nil && PFFacebookUtils.isLinkedWithUser(PFUser.currentUser())) {
            performSegueWithIdentifier("HomeViewControllerSegue", sender: nil)
            
            authService.fetchAndStoreFacebookInfo(nil)
        }
    }
    
    @IBAction func loginSelected(sender: AnyObject) {
        authService.authenticateWithFacebook { error in
            if (error == nil) {
                self.performSegueWithIdentifier("HomeViewControllerSegue", sender: nil)
                
                self.authService.fetchAndStoreFacebookInfo(nil)
            }
            else {
                println("Failed to log user in \(error)")
            }
        }
    }
}
