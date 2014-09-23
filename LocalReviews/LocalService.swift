//
//  LocalService.swift
//  LocalReviews
//
//  Created by Vijay Karunamurthy on 9/19/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

class LocalService: BDBOAuth1RequestOperationManager {
    
    
    var dataHandler: (([Place]) -> ())?
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken token: String!, accessSecret tokenSecret: String!) {
        var baseURL = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL:baseURL, consumerKey:key, consumerSecret:secret)
        var actoken = BDBOAuthToken(token: token, secret: tokenSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(actoken)
    }
    
    func setDataHandler( dataHandler: (([Place]) -> ())) {
        self.dataHandler = dataHandler
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchWithTerm(term: String, success: ((AFHTTPRequestOperation!,AnyObject!) -> Void)!, failure: ((AFHTTPRequestOperation!,NSError!)->Void)! ) -> AFHTTPRequestOperation {
        var params = ["term":term, "location":"San Francisco"] as NSDictionary
        return self.GET("search", parameters: params, success: success, failure: failure)
    }
    
    func unwrapPlacesJSON(response: AFHTTPRequestOperation!,error: AnyObject!) -> Void {
        var places = [Place]()

        //println("\(response.responseString)")
        let json = JSONValue(response.responseString)
        var object: AnyObject? = NSJSONSerialization.JSONObjectWithData(response.responseData, options: NSJSONReadingOptions(0) , error: nil)
        if (object == nil || !(object is NSDictionary)) { self.handleNetworkError("error 4 \(object)") }
        else {
            let obdict = object! as NSDictionary
            let bizzitem = obdict["businesses"]
            if (bizzitem == nil || !(bizzitem is NSArray)) { self.handleNetworkError("error 5 \(bizzitem)") }
                let bizarray = bizzitem as NSArray
                for biz in bizarray {
                    if (!(biz is NSDictionary)) { println("Skipping item \(biz)") }
                    else {
                      let bizdict = biz as NSDictionary
                      let location = bizdict["location"]
                      if (location == nil || !(location is NSDictionary)) { println("Skipping item - no location \(location)") }
                      else {
                        let loctdict = location as NSDictionary
                        let identifier = bizdict["id"] as NSString?
                        let title = bizdict["name"] as NSString?
                        let streetAddress = (loctdict["address"] as NSArray)[0] as NSString
                        let thumbURL = bizdict["image_url"] as NSString?
                        let ratingImgUrl = bizdict["rating_img_url_small"] as NSString?
                        if (identifier == nil || title == nil || thumbURL == nil || ratingImgUrl == nil) {
                            println("Skipping nil items \(bizdict)")
                        } else {
                            var place = Place(identifier: identifier!)
                            place.title = title!
                            place.streetAddress = streetAddress
                            place.thumbURL = thumbURL!
                            place.ratingImgUrl = ratingImgUrl!
                            places.append(place)
                        }
                      }
                    }
                }
        }
            
        
        /*
        let jbiz = json["businesses"]
        switch jbiz {
        case .JArray(let bizArray):
            for biz in bizArray {
                
                let identifier = biz["id"].string
                let title = biz["name"].string
                let streetAddress = biz["location"]["address"].string
                let thumbURL = biz["image_url"].string
                let ratingImgUrl = biz["rating_img_url_small"].string
                
                if (identifier == nil || title == nil || streetAddress == nil || thumbURL == nil || ratingImgUrl == nil) {
                    println("error 2")
                } else {
                    
                    // Check if this movie is already in the array
                    // var match_movie = self.movies.filter({$0.identifier == identifier})
                    // if (match_movie.count == 0) {
                        var place = Place(identifier: identifier!)
                        place.title = title!
                        place.streetAddress = streetAddress!
                        place.thumbURL = thumbURL!
                        place.ratingImgUrl = ratingImgUrl!
                        places.append(place)
                   // }
                }
            }
        default:
            self.handleNetworkError("error 3 \(json.object?.count)")
        }

        */
        
        self.dataHandler?(places)
        
        
    }
    
    func handleNetworkError(description: String) {
        println("Network error \(description)")
    }
}