//
//  GoogleAutocompleteService.swift
//  Explore
//
//  Created by Aryan on 10/12/14.
//  Copyright (c) 2014 aryaxt. All rights reserved.
//

import Foundation

class GoogleAutocompleteService {
    
    func fetchLocations(query: String, block: ([AutocompleteLocation]?, NSError?) -> Void) {
        
        PFCloud.callFunctionInBackground("Autocomplete", withParameters: ["query" : query]) { (result, error) in
            if let recievedError = error {
                block(nil, error)
            }
            else {
                var autocompleteResult = [AutocompleteLocation]()
                var data = result.dataUsingEncoding(NSUTF8StringEncoding)!
                var error: NSError?;
                var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
                
                if let predictions = dictionary["predictions"] as? [NSDictionary] {
                    
                    for prediction in predictions {
                        var autoComplere = AutocompleteLocation(name: prediction["description"] as String, placeId: prediction["place_id"] as String)
                        autocompleteResult.append(autoComplere)
                    }
                }
                
                block(autocompleteResult, nil)
            }
        }
    }
}