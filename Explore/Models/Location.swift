//
//  Location.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class Location: PFObject, PFSubclassing {
    
    @NSManaged var formattedAddress: String?
    @NSManaged var street: String?
    @NSManaged var city: String?
    @NSManaged var state: String?
    @NSManaged var country: String?
    @NSManaged var postalCode: String?
    @NSManaged var googlePlaceId: String?
    @NSManaged var geoPoint: PFGeoPoint?
    
    override init() {
        super.init()
    }
    
    init(googlePladeDetail: GooglePlaceDetail) {
        super.init()
        
        self.formattedAddress = googlePladeDetail.formattedAddress
        self.street = googlePladeDetail.fullStreet()
        self.city = googlePladeDetail.city
        self.state = googlePladeDetail.state
        self.country = googlePladeDetail.country
        self.postalCode = googlePladeDetail.postalCode
        self.googlePlaceId = googlePladeDetail.placeId
        self.geoPoint = PFGeoPoint(latitude: googlePladeDetail.latitude!, longitude: googlePladeDetail.longitude!)
    }
    
    class func parseClassName() -> String {
        return "Location"
    }
    
    override class func load() {
        registerSubclass()
    }
}