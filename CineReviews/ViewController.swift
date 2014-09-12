//
//  ViewController.swift
//  CineReviews
//
//  Created by Vijay Karunamurthy on 9/10/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        requestAPIData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    func requestAPIData() {
        
        
        
        var url: String = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=mkwnbrc7g34k64vpq96nshc9"
        
        /* Port of the Obj-C example from @sandofsy -
            switched to the Alamofire code below
        
            var request = NSMutableURLRequest(URL: NSURL(string: url))
            request.setValue("application/json",forHTTPHeaderField:"Accept")
            request.HTTPMethod = "GET"
            request.setValue("curl/7.37.1", forHTTPHeaderField:"User-Agent")
        
            println("\(request)")
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                println("\(error)")
                var object: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0) , error: nil)
                println("\(object)")
                })
        
        */
        
        Alamofire.request(.GET, url, encoding: .JSON).response { (request, response, data, error) in
        }
        
        
        
    }
    
}

