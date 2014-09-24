//
//  FilterSettings.swift
//  LocalReviews
//
//  Created by Vijay Karunamurthy on 9/23/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

class FilterSettings {
    
    let categories = Categories().catList
    var categoriesSelected = [Bool]()
    var distance = 10000
    var sort = 0
    var deal = 0

    let sortTitles = ["Best Match", "Distance", "Highest Rated"]
    
    var searchTerm = "Thai"
    
    var categoryCount = 0
    
    init() {
        
        self.categoryCount = self.categories.count
        for category in self.categories {
            self.categoriesSelected.append(false)
        }
    }
    
    lazy var categoriesString: String = {
            var cats = ""
            var iter = 0
            for catpair in self.categories {
              if (self.categoriesSelected[iter]) {
                var new_categories = ""
                if (iter > 0) {
                    new_categories = "\(cats), \((catpair)[1])"
                } else {
                    new_categories = "\((catpair)[1])"
                }
                iter += 1
                cats = new_categories
                }
            }
            return cats
        
    }()
    
    
    
}