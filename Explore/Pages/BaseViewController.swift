//
//  BaseViewController.swift
//  Explore
//
//  Created by Aryan on 10/14/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class BaseViewController: UIViewController {
    
    func showLoader() {
        SVProgressHUD.show()
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
}
