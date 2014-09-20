//
//  LocalService.swift
//  LocalReviews
//
//  Created by Vijay Karunamurthy on 9/19/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

class LocalService: BDBOAuth1RequestOperationManager {
    
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken token: String!, accessSecret tokenSecret: String!) {
        var baseURL = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL:baseURL, consumerKey:key, consumerSecret:secret)
        var actoken = BDBOAuthToken(token: token, secret: tokenSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(actoken)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchWithTerm(term: String, success: ((AFHTTPRequestOperation!,AnyObject!) -> Void)!, failure: ((AFHTTPRequestOperation!,NSError!)->Void)! ) -> AFHTTPRequestOperation {
        var params = ["term":term, "location":"San Francisco"] as NSDictionary
        return self.GET("search", parameters: params, success: success, failure: failure)
    }
    
}