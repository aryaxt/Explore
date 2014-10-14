//
//  UserNotificationSetting.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class UserNotificationSetting: PFObject, PFSubclassing {
    
    @NSManaged var enabled: NSNumber
    @NSManaged var notificationSetting: UserNotificationSetting
    
    
    class func parseClassName() -> String {
        return "UserNotificationSetting"
    }
    
    override class func load() {
        registerSubclass()
    }
}