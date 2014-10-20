//
//  AppDelegate.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("tNn0p6pBjYzIJdfC8slhNqKYcl47jKZQ3Jrvu1KO", clientKey: "h3ch8OOAeW6hHBjMLT3Ewyn8yo3syUjOLQlnmXyf");
    
        PFFacebookUtils.initializeFacebook()
        
        // TODO Make this an extension
        var menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewContorller") as UIViewController
        SlideNavigationController.sharedInstance().leftMenu = menu
        
//        GoogleLocationService().fetchLocations("1190 mission street", block: { (locations, error) -> Void in
//            var location = locations![0]
//            
//            GoogleLocationService().fetchLocation(location.placeId, block: { (location, error) -> Void in
//                
//            })
//        })
        
        
        
//        var category = Category()
//        category.name = "Sport"

//        createEvent(category, activityName: "Biking", name: "Biking in the desert", url: "http://medinatours.net/wp-content/uploads/2014/07/biking.jpg")
//        createEvent(category, activityName: "Hiking", name: "Hiking in the desert", url: "http://festgift.com/wp-content/uploads/2014/08/Labor-Day-Activities-Hiking-on-Labor-Day-Weekend.jpg")
//        createEvent(category, activityName: "Scuba Diving", name: "Scuba Diving in Cancun", url: "http://www.gargnanosulgarda.com/image/scubascuba2.jpg")
//        createEvent(category, activityName: "Beer Pong", name: "Beer Pong", url: "http://s3.amazonaws.com/rapgenius/beer_pong1.jpg")
        
        return true
    }
    
    func createEvent(category: Category, activityName: String, name: String, url: String) {
        var activity = Activity()
        activity.name = activityName
        activity.category = category
        
        var location = Location()
        location.street = "1190 mission"
        location.city = "San Francisco"
        location.country = "Unitest States"
        location.state = "CA"
        
        var event = Event()
        event.name = name
        event.startTime = NSDate()
        event.endTime = NSDate()
        event.activity = activity
        event.location = location
        event.creator = User.currentUser()
        event.photo = PFFile(data: NSData(contentsOfURL: NSURL(string: url)))
        
        event.saveInBackgroundWithBlock { (success, error) -> Void in
            println(error)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        PFFacebookUtils.session().close()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
        
        return FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication, withSession: PFFacebookUtils.session())
    }

}

