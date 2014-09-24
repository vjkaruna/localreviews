//
//  CategoryViewController.swift
//  LocalReviews
//
//  Created by Vijay Karunamurthy on 9/23/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

class CategoryViewController: UITableViewController, UITableViewDataSource {
    
    var sett = FilterSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Filters"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sett.categoryCount
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("categoryListCell") as UITableViewCell
    if (sett.categoriesSelected[indexPath.row] == true) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    cell.textLabel?.text = self.sett.categories[indexPath.row][0]
    return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sett.categoriesSelected[indexPath.row] = !sett.categoriesSelected[indexPath.row]
        self.tableView.reloadData()
    }
    
    
    
}