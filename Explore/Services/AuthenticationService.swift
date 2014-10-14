//
//  AuthenticationService.swift
//  Explore
//
//  Created by Aryan on 10/13/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class AuthenticationService {
    
    func authenticateWithFacebook(block: (NSError?) -> Void) {
        var permissionArray = ["public_profile", "email", "user_friends"]
        // TODO: Find out what permissions are needed
        
        PFFacebookUtils.logInWithPermissions(permissionArray) { (user, error) in
            
            if let loggedInUser = user {
                self.fetchAndStoreFacebookInfo { error in
                    block(error)
                }
            }
            else {
                block(error)
            }
        }
    }
    
    func fetchAndStoreFacebookInfo (block: ((NSError?) -> Void)?) {
        var request = FBRequest.requestForMe()
        
        request.startWithCompletionHandler() { (requestConnection, result, error) in
            
            if let userResult = result as? NSDictionary {
                
                var user = User.currentUser()
                user.firstName = userResult["first_name"] as String
                user.lastName = userResult["last_name"] as String
                user.email = userResult["email"] as String
                
                if let dateString = userResult["birthday"] as? String {
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    user.birthDay = dateFormatter.dateFromString(dateString)!
                }
                
                switch userResult["gender"] as String {
                case "male":
                    user.gender = 1
                    
                case "female":
                    user.gender = 2
                    
                default:
                    user.gender = 0
                    
                }
                
                var facebookId = userResult["id"] as String
                user.photoUrl = "https://graph.facebook.com/\(facebookId)/picture"
                
                user.saveInBackgroundWithBlock { (success, error) in
                    if let aBlock = block {
                        aBlock(error)
                    }
                }
            }
        }
    }
    
}
