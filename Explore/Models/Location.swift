//
//  Location.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class Location: PFObject, PFSubclassing {
    
    @NSManaged var street1: String
    @NSManaged var street2: String
    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var country: String
    @NSManaged var googlePlaceId: String
    @NSManaged var geoPoint: PFGeoPoint
    
    class func parseClassName() -> String {
        return "Location"
    }
    
    override class func load() {
        registerSubclass()
    }
}