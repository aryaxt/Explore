//
//  User.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class User: PFUser, PFSubclassing {
    
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var photoUrl: String
    @NSManaged var birthDay: NSDate
    @NSManaged var gender: NSNumber
    
    override class func load() {
        registerSubclass()
    }
    
}
