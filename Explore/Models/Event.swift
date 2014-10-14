//
//  Event.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class Event: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var detail: String
    @NSManaged var date: NSDate
    @NSManaged var canceled: NSNumber
    @NSManaged var attendeeCount: NSNumber
    @NSManaged var creator: User
    @NSManaged var activity: Activity
    @NSManaged var location: Location
    @NSManaged var attendees: PFRelation
    @NSManaged var photo: PFFile
    
    class func parseClassName() -> String {
        return "Event"
    }
    
    override class func load() {
        registerSubclass()
    }
}
