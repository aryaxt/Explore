//
//  StickyHeaderView.swift
//  Explore
//
//  Created by Aryan on 10/19/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class StickyHeaderView: UIView {
    
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.backgroundColor = UIColor.primaryColor()
    }
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set(value) {
            titleLabel.text = value
            titleLabel.sizeToFit()
        }
    }
}
