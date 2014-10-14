//
//  HomeViewController.swift
//  Explore
//
//  Created by Aryan on 10/13/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SlideNavigationControllerDelegate {
    
    lazy var eventService = EventService()
    var events = [Event]()
    
    // MARK: - ViewContorller Methods
    
    override func viewDidLoad() {
        eventService.fetchEventFeeds { (newEvents, error)  in
            if (error != nil) {
                
            }
            else {
                
            }
        }
    }
    
    // MARK: - SlideNavigationController Delegate
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
    
    // MARK: - TableView Delegate & Datasource -
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
