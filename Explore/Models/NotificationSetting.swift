//
//  NotificationSetting.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class NotificationSetting: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var detail: String
    @NSManaged var defaultValue: NSNumber

    
    class func parseClassName() -> String {
        return "NotificationSetting"
    }
    
    override class func load() {
        registerSubclass()
    }
}