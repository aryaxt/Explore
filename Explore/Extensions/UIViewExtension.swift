//
//  UIViewExtension.swift
//  Explore
//
//  Created by Aryan on 10/19/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

extension UIView {
    
    func addShadow() {
        var layer = self.layer;
        
        layer.shadowOffset = CGSizeMake(1, 1)
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.darkGrayColor().CGColor
        layer.shadowOpacity = 0.8
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.mainScreen().scale
        
        let shadowWithInset: CGFloat = 2.0
        let shadowHeightOutset: CGFloat = 4.0
        var size = layer.bounds.size
        var shadowRect = CGRectMake(shadowWithInset, size.height-shadowHeightOutset, size.width-(shadowWithInset*2), shadowHeightOutset)
        layer.shadowPath = UIBezierPath(rect: shadowRect).CGPath
    }
}
