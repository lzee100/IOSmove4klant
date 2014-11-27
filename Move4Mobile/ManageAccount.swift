//
//  ManageAccount.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class ManageAccount: UIViewController {
    @IBOutlet weak var button_change: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        likes.append("spijkers")
        likes.append("verf")
        
        var image = UIImage(named: "emptyprofile")
        imageView_profilePicture.image = image

        
        // set person info 
        label_firstNameOutput.text  = name
        label_lastNameOutput.text   = sirName
        label_emailAdresOutput.text = email
    }

    // table functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (likes.count != 0)
        {
            return likes.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let id = "manageAccountCell"
        var cell : ManageAccountCell? = tableView.dequeueReusableCellWithIdentifier(id) as ManageAccountCell? //or your custom class
        
        if (cell == nil) {
            cell = tableView.dequeueReusableCellWithIdentifier(id) as ManageAccountCell!
        }
        
        cell!.label_Category.text = likes[indexPath.row]
        
        return cell!
    }

    

   

}
