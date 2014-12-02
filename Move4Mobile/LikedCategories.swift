//
//  LikedCategories.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class LikedCategories: UIViewController {
    @IBOutlet var label_info: UILabel!
    @IBOutlet var tableLikes: UITableView!
    @IBOutlet var button_save: UIBarButtonItem!
    var allCategories = [Category]()
    var likes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (allCategories.count == 0){
        var cat1 : Category = Category(ID: 1, Name: "Verf", liked: 0)
        var cat2 : Category = Category(ID: 2, Name: "Spijkers", liked: 1)
        var cat3 : Category = Category(ID: 1, Name: "Verf", liked: 0)
        var cat4 : Category = Category(ID: 2, Name: "Spijkers", liked: 1)
        var cat5 : Category = Category(ID: 1, Name: "Verf", liked: 0)
        var cat6 : Category = Category(ID: 2, Name: "Spijkers", liked: 1)
        var cat7 : Category = Category(ID: 1, Name: "Verf", liked: 0)
        var cat8 : Category = Category(ID: 2, Name: "Spijkers", liked: 1)
        allCategories.append(cat1)
        allCategories.append(cat2)
        allCategories.append(cat3)
        allCategories.append(cat4)
        allCategories.append(cat5)
        allCategories.append(cat6)
        allCategories.append(cat7)
        allCategories.append(cat8)
        }
        
        //allCategories.append("spijkers")
        //allCategories.append("verf")
        tableLikes.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // table functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (allCategories.count != 0)
        {
            return allCategories.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let id = "likedCategoriesCell"
        var cell : LikedCategoriesCell? = tableView.dequeueReusableCellWithIdentifier(id) as LikedCategoriesCell? //or your custom class
        
        if (cell == nil) {
            cell = tableView.dequeueReusableCellWithIdentifier(id) as LikedCategoriesCell!
        }
        
        cell!.label_category.text = allCategories[indexPath.row].name!
        if (allCategories[indexPath.row].liked == 0){
            cell!.switch_like.setOn(false, animated: true)
        } else {
            cell!.switch_like.setOn(true, animated: true)
        }
        cell!.switch_like.addTarget(self, action:"switchChanged:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell!
    }
    
    func switchChanged (sender : UISwitch) {
        let cell : UITableViewCell = sender.superview!.superview as UITableViewCell
        let indexPath : NSIndexPath = tableLikes.indexPathForCell(cell)!
        if (allCategories[indexPath.row].liked == 1){
            allCategories[indexPath.row].liked = 0
        }
        else{
            allCategories[indexPath.row].liked = 1
        }
    }
    
    @IBAction func save(sender: AnyObject) {
        var categoriesToSave = ""
        var i = 0
        for category in allCategories {
            if (category.liked! == 1){
                categoriesToSave += category.name!
            }
            i++
        }
        let alert = UIAlertView()
        alert.title = "Title"
        alert.message = "To save: " + categoriesToSave
        alert.addButtonWithTitle("Ok")
        alert.show()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as ManageAccount
        destinationVC.allCategories = self.allCategories
    }
    
    
    
}
