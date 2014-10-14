//
//  Category.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class Category: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    
    class func parseClassName() -> String {
        return "Category"
    }
    
    override class func load() {
        registerSubclass()
    }
}
