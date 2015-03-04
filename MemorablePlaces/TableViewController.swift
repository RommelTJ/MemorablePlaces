//
//  TableViewController.swift
//  MemorablePlaces
//
//  Created by Rommel Rico on 3/4/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit

var activePlace:Int = 0
var places = [Dictionary<String, String>()]
var addingPlace = false

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if places.count == 1 {
            places.removeAtIndex(0)
        }
        
        if places.count == 0 {
            places.append(["name":"Taj Mahal", "lat":"27.175277", "lon":"78.042128" ])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return places.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = places[indexPath.row]["name"]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activePlace = indexPath.row
        self.performSegueWithIdentifier("findPlace", sender: indexPath)
    }

    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addPlace" {
            addingPlace = true
        }
    }
}
