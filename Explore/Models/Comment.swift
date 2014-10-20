//
//  Comment.swift
//  Explore
//
//  Created by Aryan on 10/18/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class Comment: PFObject, PFSubclassing {
    
    @NSManaged var user: User
    @NSManaged var body: String
    
    class func parseClassName() -> String {
        return "Comment"
    }
    
    override class func load() {
        registerSubclass()
    }
}
