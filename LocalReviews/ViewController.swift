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
    
    @IBOutlet weak var netErrorLabel: UILabel!
    @IBOutlet weak var movieTableView: UITableView!
    
    var movies = [Movie]()
    var tvc = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Rotten Tomatoes"
        
        self.tvc.tableView = movieTableView
        
        var messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        messageLabel.backgroundColor = UIColor.grayColor()
        messageLabel.text = "No movies loaded. Please pull to refresh."
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.sizeToFit()
        
        self.movieTableView.backgroundView = messageLabel
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("requestAPIData"), forControlEvents: UIControlEvents.ValueChanged)
        self.tvc.refreshControl = refreshControl
        
        requestAPIData()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (movies.count > 0) {
            self.movieTableView.backgroundView!.hidden = true
            return 1
        } else {
            self.movieTableView.backgroundView!.hidden = false
        }
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
        let cell = tableView.dequeueReusableCellWithIdentifier("mvItemCell") as UITableViewCell
        let nameLabel: UILabel = cell.viewWithTag(102) as UILabel
        let thumbnail: UIImageView = cell.viewWithTag(101) as UIImageView
              
        if (indexPath.row < movies.count) {
            nameLabel.attributedText = movies[indexPath.row].attributedShortDesc
            thumbnail.sd_setImageWithURL(NSURL(string: movies[indexPath.row].thumbURL))            
        } else {
            nameLabel.text = "Row \(indexPath.row)"
        }
        // cell.imageView = "http://content8.flixster.com/movie/11/17/72/11177246_tmb.jpg"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "pushMovieDetail") {
            let dvc = segue.destinationViewController as DetailViewController
            let sourcerow = self.movieTableView.indexPathForSelectedRow()?.row
            if (sourcerow != nil) {
                dvc.movie = movies[sourcerow!]
            }
        }
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
        
        netErrorLabel.hidden = true
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Alamofire.request(.GET, url).responseJSON { (request, response, data, error) in
            if (error != nil) {
                self.handleNetworkError("error 1")
                return
            }
            
            let json = JSONValue(data as AnyObject!)
            switch json["movies"] {
                case .JArray(let moviesArray):
                    for movie in moviesArray {

                        let identifier = movie["id"].string
                        let title = movie["title"].string
                        let synopsis = movie["synopsis"].string
                        let thumbURL = movie["posters"]["thumbnail"].string
                        let mpaaRating = movie["mpaa_rating"].string
                        let year = movie["year"].integer
                        let criticScore = movie["ratings"]["critics_score"].integer
                        let audienceScore = movie["ratings"]["audience_score"].integer
                        
                        if (identifier == nil || title == nil || synopsis == nil || thumbURL == nil || mpaaRating == nil) {
                            println("error 2")
                        } else {

                            // Check if this movie is already in the array
                            var match_movie = self.movies.filter({$0.identifier == identifier})
                            if (match_movie.count == 0) {
                                var movieObj = Movie(identifier: identifier!)
                                movieObj.title = title!
                                movieObj.synopsis = synopsis!
                                movieObj.thumbURL = thumbURL!
                                movieObj.mpaaRating = mpaaRating!
                                movieObj.year = year
                                movieObj.criticScore = criticScore
                                movieObj.audienceScore = audienceScore
                                self.movies.append(movieObj)
                            }
                        }
                    }
                default:
                    self.handleNetworkError("error 3 \(json)")
            }
            for movie in self.movies {
                //println("\(movie.title)")
            }
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.movieTableView.reloadData()
            self.tvc.refreshControl?.endRefreshing()
            
        }
    }
    
    func handleNetworkError(description: String) {
        println("Network error \(description)")
        netErrorLabel.hidden = false
    }
    
}

