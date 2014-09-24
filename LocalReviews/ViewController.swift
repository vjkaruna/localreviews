//
//  ViewController.swift
//  CineReviews
//
//  Created by Vijay Karunamurthy on 9/10/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var netErrorLabel: UILabel!
    @IBOutlet weak var movieTableView: UITableView!
    
    var places = [Place]()
    var tvc = UITableViewController()
    
    var yelpConsumerKey = "IegkwdVJdoKBK20pl4Zvsg"
    var yelpConsumerSecret = "EmpvxB9tE7Thd-fbSR85VxwxQZU"
    var yelpToken = "73vhsz8OPMjUMrTEP612vDliRmHH-TaS"
    var yelpTokenSecret = "vFmFp_QcFIMqExdYo_G6SSZCDQc"
    var localService: LocalService?
    
    var filterSettings = FilterSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Yelp"
        
        self.tvc.tableView = movieTableView
        
        var messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        messageLabel.backgroundColor = UIColor.whiteColor()
        messageLabel.text = "No reviews loaded. Please pull to refresh."
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.sizeToFit()
        
        self.movieTableView.backgroundView = messageLabel
        self.movieTableView.estimatedRowHeight = 100.0;
        self.movieTableView.rowHeight = UITableViewAutomaticDimension;

        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("requestAPIData"), forControlEvents: UIControlEvents.ValueChanged)
        self.tvc.refreshControl = refreshControl
        
        localService = LocalService(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        //localService?.searchWithTerm("thai", success: {(req,err) in println("\(req) \(err)")} , failure: {(req,err) in println("\(req) \(err)")} )
        localService?.setDataHandler({(places) in
            self.places = places
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.movieTableView.reloadData()
            self.tvc.refreshControl?.endRefreshing()
        })
        localService?.searchWithTerm(filterSettings.searchTerm, success: localService?.unwrapPlacesJSON, failure: {(req,err) in println("\(req) \(err)")} )
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (places.count > 0) {
            self.movieTableView.backgroundView!.hidden = true
            return 1
        } else {
            self.movieTableView.backgroundView!.hidden = false
        }
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
        let opcell = tableView.dequeueReusableCellWithIdentifier("mvItemCell") as UITableViewCell?
        if (opcell == nil) {
            println("couldn't get reusable cell")
            return UITableViewCell()
        }
        var cell = opcell!
        let thumbnail: UIImageView = cell.viewWithTag(101) as UIImageView
        let nameLabel: UILabel = cell.viewWithTag(102) as UILabel
        let ratingImg: UIImageView = cell.viewWithTag(103) as UIImageView
        let ratingLabel: UILabel = cell.viewWithTag(104) as UILabel
        let categories: UILabel = cell.viewWithTag(105) as UILabel
        let streetAddress: UILabel = cell.viewWithTag(106) as UILabel
              
        if (indexPath.row < places.count) {
            //nameLabel.attributedText = places[indexPath.row].title
            nameLabel.text = places[indexPath.row].title
            thumbnail.sd_setImageWithURL(NSURL(string: places[indexPath.row].thumbURL))
            ratingImg.sd_setImageWithURL(NSURL(string: places[indexPath.row].ratingImgURL))
            if (places[indexPath.row].ratingCount < 100) {
                ratingLabel.text = "\(places[indexPath.row].ratingCount) ratings"
            } else {
                ratingLabel.text = "\(places[indexPath.row].ratingCount)"
            }
            categories.text = places[indexPath.row].categories
            streetAddress.text = places[indexPath.row].streetAddress
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
                 dvc.place = places[sourcerow!]
            }
        } else if (segue.identifier == "filterSegue") {
            
        }
    }
    
    
    func requestAPIData() {
        
        
        var url: String = ""
        // var url: String = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=mkwnbrc7g34k64vpq96nshc9"
        
        /*
        
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

        */
    }
    
    func handleNetworkError(description: String) {
        println("Network error \(description)")
        netErrorLabel.hidden = false
    }
    
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        if (searchString == "") {
            filterSettings.searchTerm = ""
            places.removeAll(keepCapacity: true)
            return true
        } else {
            filterSettings.searchTerm = searchString
            println("Searching \(searchString)")
            self.localService?.searchWithTerm(filterSettings.searchTerm, success: localService?.unwrapPlacesJSON, failure: {(req,err) in self.handleNetworkError(("\(req) \(err)"))} )
            return true
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == "") {
            filterSettings.searchTerm = ""
            places.removeAll(keepCapacity: true)
        } else {
            filterSettings.searchTerm = searchText
            println("Searching \(searchText)")
            self.localService?.searchWithTerm(filterSettings.searchTerm, success: localService?.unwrapPlacesJSON, failure: {(req,err) in self.handleNetworkError(("\(req) \(err)"))} )
        }
    }
    
}

