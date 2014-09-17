//
//  Movies.swift
//  CineReviews
//
//  Created by Vijay Karunamurthy on 9/14/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

class Movie {
    
    // passed through init
    var identifier: String = ""
    
    // metadata
    var title: String = ""
    var synopsis: String = ""
    var thumbURL: String = ""
    var mpaaRating: String = ""
    
    init(identifier: String) {
        self.identifier = identifier
        
    }
    
    lazy var posterURL: String = {
        return self.thumbURL.stringByReplacingOccurrencesOfString("tmb", withString: "det")
    }()
}