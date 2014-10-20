//
//  EventAttendee.swift
//  Explore
//
//  Created by Aryan on 10/17/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class EventAttendee: PFObject, PFSubclassing {
    
    @NSManaged var user: User
    @NSManaged var event: Event
    @NSManaged var confirmed: NSNumber
    @NSManaged var eventUpdateNotification: NSNumber
    @NSManaged var eventCommunicationNotification: NSNumber
    
    class func parseClassName() -> String {
        return "EventAttendee"
    }
    
    override class func load() {
        registerSubclass()
    }
}
