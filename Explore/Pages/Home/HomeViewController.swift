//
//  HomeViewController.swift
//  Explore
//
//  Created by Aryan on 10/13/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, SlideNavigationControllerDelegate {
    @IBOutlet var tableView: UITableView!
    private var perPage = 2
    private var page = 1
    lazy var eventService = EventService()
    var eventsDictionary = OrderedDictionary<NSDate, [Event]>()
    
    // MARK: - ViewContorller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoader()
        fetchAndPopulateNextPageData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow() {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        super.didMoveToParentViewController(parent)

        if (self.tableView.pullToRefreshView == nil) {
            tableView.addPullToRefreshWithActionHandler {
                self.page = 1
                // AG: Don't remove things here in case call fails
                self.eventsDictionary.removeAll(false)
                self.tableView.reloadData()
                self.tableView.showsInfiniteScrolling = true
                self.fetchAndPopulateNextPageData()
            }
        }
        
        if (self.tableView.infiniteScrollingView == nil) {
            tableView.addInfiniteScrollingWithActionHandler {
                self.fetchAndPopulateNextPageData()
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EventViewController") {
            var eventViewController = segue.destinationViewController as EventViewController
            var indexPath = tableView.indexPathForSelectedRow()!
            eventViewController.event = eventsDictionary[indexPath.section]![indexPath.row]
        }
    }
    
    // MARK: - SlideNavigationController Delegate
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
    
    // MARK: - TableView Delegate & Datasource -
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return eventsDictionary.keys().count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsDictionary[section]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var event = eventsDictionary[indexPath.section]![indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as EventCell
        cell.populateEvent(event)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        
        // TODO: Don't hardcode this
        var header: StickyHeaderView = NSBundle.mainBundle().loadNibNamed("StickyHeaderView", owner: nil, options: nil).first as StickyHeaderView
        header.title = dateFormatter.stringFromDate(eventsDictionary.keys()[section])
        return header
    }
    
    // MARK: - Private Methods
    
    func fetchAndPopulateNextPageData() {
        eventService.searchEvents(page, perPage: perPage) { (newEvents, error)  in
            if (error == nil) {
                self.page++
                
                newEvents?.each { self.addEvent($0) }
                self.tableView.reloadData()
                
                if (newEvents?.count < self.perPage) {
                    self.tableView.showsInfiniteScrolling = false
                }
            }
            else {
                // TODO: Display Alert
            }
            
            self.tableView.infiniteScrollingView.stopAnimating();
            self.tableView.pullToRefreshView.stopAnimating();
            self.hideLoader()
        }

    }
    
    func addEvent(event: Event) {
        
        func existingSectionKey() -> NSDate? {
            for date in eventsDictionary.keys() {
                if date.isSameDayAs(event.startTime) {
                    return date
                }
            }
            
            return nil
        }
        
        if let key = existingSectionKey() {
            var eventsInGroup = eventsDictionary[key]
            eventsInGroup!.append(event)
            eventsDictionary[key] = eventsInGroup
        }
        else {
            eventsDictionary[event.startTime] = [event]
        }
    }
}
