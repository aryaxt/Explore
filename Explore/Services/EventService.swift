//
//  EventService.swift
//  Explore
//
//  Created by Aryan on 10/13/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class EventService {
    
    func searchEvents(page: Int, perPage: Int, block: ([Event]?, NSError?) -> Void) {
        var query = Event.query()
        query.includeKey("location")
        query.orderByAscending("startDate")
        query.limit = perPage
        query.skip = (page-1) * perPage
        query.findObjectsInBackgroundWithCompletion(Event.self, closure: block)
    }
    
    func fethEvent(eventId: String, block: (Event?, NSError?) -> Void) {
        var query = Event.query()
        query.whereKey("objectId", equalTo: eventId);
        query.findObjectInBackgroundWithCompletion(Event.self, closure: block)
    }
    
    func fetchEventAttendees(eventId: String, pageNumber: Int, perPage: Int, block: ([EventAttendee]?, NSError) -> Void) {
        var query = EventAttendee.query()
    }
    
    func joinEvent(eventId: String, block: (EventAttendee?, NSError?) -> Void) {
        PFCloud.callFunctionInBackground("JoinEvent", withParameters: ["eventId": eventId]) { (result, error) in
            if (error == nil) {
                block(result as? EventAttendee, nil)
            }
            else {
                block(nil, error)
            }
        }
    }
    
    func leaveEvent(eventId: String, block: (NSError?) -> Void) {
        PFCloud.callFunctionInBackground("LeaveEvent", withParameters: ["eventId": eventId]) { (result, error) in
            block(error)
        }
    }
    
    func cancelEvent(event: Event, block: (NSError?) -> Void) {
        if (event.creator .isEqual(User.currentUser())) {
            event.canceled = true
            event.saveInBackgroundWithBlock() { (success, error) in
                block(error)
            }
        }
        else {
            block(NSError(domain: "You are not the owener of this event", code: 0, userInfo: nil))
        }
    }
    
    func fetchMyAttendee(eventId: String, block: (EventAttendee?, NSError?) -> Void) {
        var eventQuery = Event.query()
        eventQuery.whereKey("objectId", equalTo: eventId)
        
        var query = EventAttendee.query()
        query.whereKey("user", equalTo: User.currentUser())
        query.whereKey("event", matchesQuery: eventQuery)
        
        query.findObjectsInBackgroundWithBlock { (attendees, error) in
            if (error != nil) {
                block(nil, error)
            }
            else {
                if (attendees.count == 0) {
                    block(nil, nil)
                }
                else {
                    block(attendees[0] as? EventAttendee, nil)
                }
            }
        }
    }
}