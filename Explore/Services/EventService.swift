//
//  EventService.swift
//  Explore
//
//  Created by Aryan on 10/13/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class EventService {
    
    func fetchEventFeeds(block: ([Event]?, NSError?) -> Void) {
        var query = PFQuery(className: "Event")
        query.findObjectsInBackgroundWithCompletion(Event.self, closure: block)
    }
    
}