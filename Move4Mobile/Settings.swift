//
//  Settings.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class Settings: UITableViewController {
    var menuTitle = [String]()
    var menuDescription = [String]()
    var segueID = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuTitle.append("Accountbeheer")
        self.menuDescription.append("Beheer hier je accountinformatie")
        self.menuTitle.append("Scan for Beacons")
        self.menuDescription.append("Test beacon Scanning")
        self.segueID.append("manageAccount")
        self.segueID.append("scanForBeacons")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return menuTitle.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var i = indexPath.row
        let id = "settingsCell"
        var cell : SettingsCell? = tableView.dequeueReusableCellWithIdentifier(id) as SettingsCell?
        
        if (cell == nil) {
            cell = tableView.dequeueReusableCellWithIdentifier(id) as SettingsCell!
        }
        
        cell!.label_menuTitle.text = menuTitle[indexPath.row]
        cell!.label_menuDescription.text = menuDescription[indexPath.row]
        
        return cell!
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
//    {
//        if (segue.identifier == "manageAccount") {
//            let view: ManageAccount = segue.destinationViewController as ManageAccount
//        }
//        if (segue.identifier == "scanForBeacons"){
//            let view: ScanForBeacons = segue.destinationViewController as ScanForBeacons
//        }
//    } // go to next screen (overview scanned beacons) if clicked on a cell
    
    
    // action to be taken when a cell is selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(segueID[indexPath.row], sender: nil)
    }

}
