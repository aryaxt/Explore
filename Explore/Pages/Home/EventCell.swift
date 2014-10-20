//
//  EventCell.swift
//  Explore
//
//  Created by Aryan on 10/14/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class EventCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attendeeCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eventImage: PFImageView!
    @IBOutlet weak var innerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        innerView.backgroundColor = UIColor.whiteSmokeColor()
        innerView.addShadow()
    }
    
    func populateEvent(event: Event) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh: mm"
        
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
        
        eventImage.file = event.photo
        eventImage.loadInBackground()
    }
}