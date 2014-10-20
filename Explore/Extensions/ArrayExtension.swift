//
//  ArrayExtension.swift
//  Explore
//
//  Created by Aryan on 10/18/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

extension Array {
    
    func each (block: (element: Element) -> Void) {
        for element in self {
            block(element: element)
        }
    }
}
