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
    @IBOutlet weak var synopsisView: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterView.sd_setImageWithURL(NSURL(string: movie!.posterURL))
 
        synopsisView.text = movie!.synopsis
        
        synopsisView.frame = CGRectMake(16, 0, 288, 800)
        synopsisView.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
