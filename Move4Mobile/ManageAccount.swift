//
//  ManageAccount.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class ManageAccount: UIViewController {
    @IBOutlet var label_TitleAccountinfo: UILabel!
    @IBOutlet var imageView_profilePicture: UIImageView!
    @IBOutlet var label_firstName: UILabel!
    @IBOutlet var label_LastName: UILabel!
    @IBOutlet var label_emailadres: UILabel!
    @IBOutlet var label_firstNameOutput: UILabel!
    @IBOutlet var label_lastNameOutput: UILabel!
    @IBOutlet var label_emailAdresOutput: UILabel!
    @IBOutlet var label_titleLikes: UILabel!
    @IBOutlet var tableView_Likes: UITableView!
    @IBOutlet var button_Change: UIBarButtonItem!
    var likes = [String]()
    
    // dummy info
    var user : User = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        likes.append("spijkers")
        likes.append("verf")
        
        var image = UIImage(named: "emptyprofile")
        imageView_profilePicture.image = image
        if (user.name == nil){
        user.createUserWithName("Leo", uLastName: "van der Zee", uEmail: "lzee100@gmail.com")
        }
        
        label_firstNameOutput.text  = user.name!
        label_lastNameOutput.text   = user.lastName!
        label_emailAdresOutput.text = user.email!
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as EditAccount
        destinationVC.user = user
    }


   

}
