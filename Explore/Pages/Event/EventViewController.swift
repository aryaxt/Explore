//
//  EventViewController.swift
//  Explore
//
//  Created by Aryan on 10/15/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class EventViewController: BaseViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var attendeeCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eventImage: PFImageView!
    @IBOutlet weak var joinLeaveCancelButton: UIButton!
    lazy var eventService = EventService()
    var event: Event!
    var myAttendee: EventAttendee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventService.fetchMyAttendee(event.objectId) { (myAttendee, error) in
            if let anError = error {
                // Do something
            }
            else {
                self.myAttendee = myAttendee
                self.updateJoinLeaveCancelButtonTitle()
            }
        }
        
        populateEvent()
    }
    
    @IBAction func joinLeaveCancelSelected(sender: AnyObject) {
        showLoader()
        
        if (event.creator.isEqual(User.currentUser())) {
            eventService.cancelEvent(event) { error in
                self.updateJoinLeaveCancelButtonTitle()
                self.hideLoader()
            }
        }
        else {
            if let attending = myAttendee {
                eventService.leaveEvent(event.objectId) { error in
                    self.myAttendee = nil
                    self.updateJoinLeaveCancelButtonTitle()
                    self.hideLoader()
                }
            }
            else {
                eventService.joinEvent(event.objectId) { (attendee, error) in
                    self.myAttendee = attendee
                    self.hideLoader()
                    self.updateJoinLeaveCancelButtonTitle()
                }
            }
        }
    }
    
    func populateEvent() {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd   hh: mm"
        
        dateLabel.attributedText = NSMutableAttributedString(
            icon: .Calendar,
            iconColor: UIColor.primaryColor(),
            text: dateFormatter.stringFromDate(event.startTime),
            textColor: UIColor.blackColor(),
            font: UIFont.mediumBoldFont())
        
        nameLabel.attributedText = NSMutableAttributedString(
            icon: .Home,
            iconColor: UIColor.whiteColor(),
            text: event.name,
            textColor: UIColor.whiteColor(),
            font: UIFont.mediumBoldFont())
        
        attendeeCountLabel.attributedText = NSMutableAttributedString(
            icon: .Users,
            iconColor: UIColor.primaryColor(),
            text: "\(event.attendeeCount)",
            textColor: UIColor.blackColor(),
            font: UIFont.mediumBoldFont())
        
        locationLabel.attributedText = NSMutableAttributedString(
            icon: .Users,
            iconColor: UIColor.primaryColor(),
            text: event.location.formattedAddress!,
            textColor: UIColor.blackColor(),
            font: UIFont.mediumBoldFont())
        
        detailLabel.text = event.detail

        eventImage.file = event.photo
        eventImage.loadInBackground()
        
        updateJoinLeaveCancelButtonTitle()
    }
    
    func updateJoinLeaveCancelButtonTitle() {
        // TODO: Handle loading ins progress
        var joinLeaveCancelTitle = ""
        
        if (event.creator.isEqual(User.currentUser())) {
            joinLeaveCancelTitle = "Cancel"
        }
        else {
            if let attending = myAttendee {
                joinLeaveCancelTitle = "Leave"
            }
            else {
                joinLeaveCancelTitle = "Join"
            }
        }
        
        joinLeaveCancelButton.setTitle(joinLeaveCancelTitle, forState: .Normal)
    }
}