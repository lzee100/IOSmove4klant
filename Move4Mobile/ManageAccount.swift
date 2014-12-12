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
    var allCategories = [Category]()
    var likedCategories = [Category]()
    var likes = [Int]()
    
    
    // dummy info
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = DataHandler.getUserFromDB()
        self.execute()
        self.reloadInputViews()
        self.imageView_profilePicture.layer.cornerRadius = 20;
        self.imageView_profilePicture.clipsToBounds = true;
        
    }
    
    // table functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (likedCategories.count > 0){
            return likedCategories.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let id = "manageAccountCell"
        var cell : ManageAccountCell? = tableView.dequeueReusableCellWithIdentifier(id) as ManageAccountCell? //or your custom class
        
        if (cell == nil) {
            cell = tableView.dequeueReusableCellWithIdentifier(id) as ManageAccountCell!
        }
        
        cell!.label_Category.text = likedCategories[indexPath.row].name
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as EditAccount
        destinationVC.user = user!
        var i = 0
        for (i = 0; i < likedCategories.count; i++){
            for category in self.allCategories {
                if (category.ID == likedCategories[i].ID){
                    category.liked = 1
                }
            }
        }

        destinationVC.allCategories = self.allCategories
        destinationVC.likedCategories = self.likedCategories
    }
    
    func execute() {
        //var image = UIImage(named: "emptyprofile")
        //imageView_profilePicture.image = image

        
        allCategories = ServerRequestHandler().getAllCategories()
        let userID = user?.getUserID()
        dispatch_async(dispatch_get_main_queue()){

        let i: () = ServerRequestHandler.getLikes3(userID!, responseMain: { (array : Array<Int>!, error  : NSError!) -> () in
                if (self.allCategories.count != 0){
                    for like in array {
                        var i = like
                        for category in self.allCategories {
                            if category.ID == i {
                                self.likedCategories.append(category)
                            }
                        }
                    }
                }
                self.tableView_Likes.reloadData()
        })

        }
        tableView_Likes.reloadData()
        label_firstNameOutput.text  = user!.name!
        label_lastNameOutput.text   = user!.lastName!
        label_emailAdresOutput.text = user!.email!
    }
    
    
}
