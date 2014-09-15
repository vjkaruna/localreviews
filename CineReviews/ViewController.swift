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
    
    @IBOutlet weak var movieTableView: UITableView!
    var movies = [Movie]()
    
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
        //let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
        let cell = tableView.dequeueReusableCellWithIdentifier("mvItemCell") as UITableViewCell
        let nameLabel: UILabel = cell.viewWithTag(102) as UILabel
        let thumbnail: UIImageView = cell.viewWithTag(101) as UIImageView
        if (indexPath.row < movies.count) {
            nameLabel.text = "\(movies[indexPath.row].title)"
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
        
        Alamofire.request(.GET, url).responseJSON { (request, response, data, error) in
            if (error != nil) {
                println("TODO: handle error 1")
            }
            
            let json = JSONValue(data as AnyObject!)
            switch json["movies"] {
                case .JArray(let moviesArray):
                    for movie in moviesArray {
                        var movieObj = Movie()
                        //let movie = movie_item.1
                        let title = movie["title"].string
                        let synopsis = movie["synopsis"].string
                        let thumbURL = movie["posters"]["thumbnail"].string
                        let posterURL = movie["posters"]["profile"].string
                        
                        if (title == nil || synopsis == nil || thumbURL == nil || posterURL == nil) {
                            println("TODO: handle error 2")
                        } else {
                            movieObj.title = title!
                            movieObj.synopsis = synopsis!
                            movieObj.thumbURL = thumbURL!
                            movieObj.posterURL = posterURL!
                            self.movies.append(movieObj)
                        }
                    }
                default:
                    let jm = json["movies"]
                    println("TODO: handle error 3 \(jm)")
            }
            for movie in self.movies {
                println("\(movie.title)")
            }
            
            self.movieTableView.reloadData()
            
        }
        
        
        
    }
    
}

