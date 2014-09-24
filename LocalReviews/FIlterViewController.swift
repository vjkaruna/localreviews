//
//  FIlterViewController.swift
//  LocalReviews
//
//  Created by Vijay Karunamurthy on 9/23/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit
import Foundation

class FilterViewController: UITableViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var sortPicker: UIPickerView!
    
    @IBOutlet weak var dealSwitch: UISwitch!
    
    @IBAction func dealAction(sender: AnyObject) {
        var myDeal = sender as UISwitch
        sett.deal = myDeal.selected ? 1 : 0
    }
    
    var sett = FilterSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Filters"
        
        self.sortPicker.dataSource = self
        self.sortPicker.delegate = self
        
        self.sortPicker.selectRow(self.sett.sort, inComponent: 0, animated: false)
        self.dealSwitch.selected = (self.sett.deal == 1)
        self.restaurantSwitch.selected = (self.sett.categoriesSelected[0] == true)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.sett.sortTitles[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.sett.sort = row
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var restaurantSwitch: UISwitch!
    
    @IBAction func restaurantAction(sender: AnyObject) {
    }
    
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    */

    
    /*
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section < 3 ) {return 1}
        else {return 4}
    }
    */
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("dealFilterCell") as UITableViewCell
            return cell
        } else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("pickerFilterCell") as UITableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("categoryFilterCell") as UITableViewCell
            return cell
        }

        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    */
    
}