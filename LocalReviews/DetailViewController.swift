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
    
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = place!.title
        let back = UIBarButtonItem()
        back.tintColor = UIColor.yellowColor()
        back.title = "Movies"
        self.navigationItem.backBarButtonItem = back
        
        posterView.sd_setImageWithURL(NSURL(string: self.place!.thumbURL))
        
        /* Couldn't get this working in time.
        
        completed: {(image: UIImage?, error: NSError?, cacheType: SDImageCacheType!, imageURL: NSURL?) in
                self.posterView.alpha = 0.0
                UIView.animateWithDuration(2.0, animations: {() in self.posterView.alpha = 1.0})
            })
        */
 
        synopsisView.attributedText = place!.attributedLongDesc
        
        synopsisView.frame = CGRectMake(16, 20, 288, 800)
        synopsisView.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
