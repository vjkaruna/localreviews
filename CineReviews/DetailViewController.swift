//
//  DetailViewController.swift
//  CineReviews
//
//  Created by Vijay Karunamurthy on 9/14/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterView: UIImageView!    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var synopsisView: UILabel!
    
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterView.sd_setImageWithURL(NSURL(string: movie.thumbURL))
        titleView.text = movie.title
        synopsisView.text = movie.synopsis
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
