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
        self.menuTitle.append("Ontkoppel account")
        self.menuDescription.append("Log uit en verwijder account gegevens")

        self.segueID.append("manageAccount")
        self.segueID.append("scanForBeacons")
        self.segueID.append("login")
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch segueID[indexPath.row] {
            
        case "manageAccount" :
            let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("navManageAccount") as UINavigationController
            self.showViewController(vc, sender: nil)
            
        case "scanForBeacons" :
            let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("navScanForBeacons") as UINavigationController
            self.showViewController(vc, sender: nil)
            
            
        case "login" :
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let nav = appDelegate.nav
            let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let vc  = storyboard.instantiateViewControllerWithIdentifier("navLogIn") as UINavigationController
            DataHandler.deleteUser()
            nav?.presentViewController(vc, animated: true, completion: nil)
            self.navigationController?.popToRootViewControllerAnimated(true)


            
        default :
            ""
        }
    }

}
