//
//  OrderedDictionary.swift
//  Explore
//
//  Created by Aryan on 10/18/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

struct OrderedDictionary <K: Hashable, V> {
    
    private var orderedKeys = [K]()
    private var keyValues = [K: V]()
    
    subscript(index: Int) -> V? {
        get {
            return keyValues[orderedKeys[index]]
        }
        set (value) {
            if let newValue = value {
                keyValues[orderedKeys[index]] = value
            }
            else {
                keyValues[orderedKeys[index]] = nil
                orderedKeys.removeAtIndex(index)
            }
        }
    }
    
    subscript(key: K) -> V? {
        get {
            return keyValues[key]!
        }
        set (value) {
            if contains(orderedKeys, key) {
                keyValues[key] = value
            }
            else {
                orderedKeys.append(key)
                keyValues[key] = value
            }
        }
    }
    
    func keys() -> [K] {
        return orderedKeys
    }
    
    mutating func removeAll(keepCapacity: Bool) {
        orderedKeys.removeAll(keepCapacity: keepCapacity)
        keyValues.removeAll(keepCapacity: keepCapacity)
    }
}

//infix operator += { associativity left precedence 140 }
//func += <K, V> (frst: OrderedDictionary<K, V>, second: (key: K, value: V)) -> Void {
//    frst[second.key] = second.value
//}
