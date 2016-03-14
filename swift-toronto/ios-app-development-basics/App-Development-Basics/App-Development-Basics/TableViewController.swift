//
//  TableViewController.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/11/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let filters = [
        "Filter 1",
        "Filter 2",
        "Filter 3",
        "Filter 4",
        "Filter 5"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath)
        cell.textLabel?.text = filters[indexPath.row]
        return cell
    }
    

}
