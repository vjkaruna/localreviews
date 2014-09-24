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
    @IBOutlet weak var openSwitch: UISwitch!
    @IBOutlet weak var hotSwitch: UISwitch!
    @IBOutlet weak var deliverySwitch: UISwitch!
    @IBOutlet weak var dealsSwitch: UISwitch!

    @IBAction func openAction(sender: AnyObject) {
    }

    @IBAction func hotAction(sender: AnyObject) {
    }
    @IBAction func deliveryAction(sender: AnyObject) {
    }

    @IBAction func dealsAction(sender: AnyObject) {
    }
    
    
    var sett = FilterSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Filters"
        
        
        self.sortPicker.dataSource = self
        self.sortPicker.delegate = self
        
        self.sortPicker.selectRow(self.sett.sort, inComponent: 0, animated: false)
        
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
    
}