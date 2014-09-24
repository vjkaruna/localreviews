//
//  FilterSettings.swift
//  LocalReviews
//
//  Created by Vijay Karunamurthy on 9/23/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

class FilterSettings {
    
    var categories = [String]()
    var distance = "1"
    var sort = 0

    var sortMap = ["Best Match": 0, "Distance": 1, "Highest Rated": 2]
    var sortTitles = [String]()
    
    var searchTerm = "Thai"
    
    init() {
        self.sortTitles = Array(sortMap.keys)
    }
    
    
}