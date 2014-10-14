//
//  Activity.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class Activity: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var detail: String
    @NSManaged var category: Category
    
    class func parseClassName() -> String {
        return "Activity"
    }
    
    override class func load() {
        registerSubclass()
    }
}