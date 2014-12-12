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
    var likedCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCategories = DataHandler.getCategoriesFromDB()
        likedCategories = DataHandler.getLikedCategoriesFromDB()
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
        if (allCategories[indexPath.row].liked == 1){
            cell!.switch_like.setOn(true, animated: true)
        } else {
            cell!.switch_like.setOn(false, animated: true)
        }
        cell!.switch_like.addTarget(self, action:"switchChanged:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell!
    }
    
    func switchChanged (sender : UISwitch) {
        let cell : UITableViewCell = sender.superview!.superview as UITableViewCell
        let indexPath : NSIndexPath = tableLikes.indexPathForCell(cell)!
        
        if (allCategories[indexPath.row].liked == 0 || allCategories[indexPath.row].liked == nil){
                allCategories[indexPath.row].liked = 1
            }
            else {
                allCategories[indexPath.row].liked = 0
            }
    }
    
    func saveData() {
        DataHandler.saveLikes(allCategories)
//        var categoriesToSave = ""
//        var i = 0
//        for category in allCategories {
//            if (category.liked != nil || category.liked == 0){
//                if category.liked! == 1 {
//                    categoriesToSave += "\n" + category.name!
//                }
//            }
//            i++
//        }
//        let alert = UIAlertView()
//        alert.title = "Title"
//        alert.message = "To save: " + categoriesToSave
//        alert.addButtonWithTitle("Ok")
//        alert.show()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        saveData()
        println("after savedata")
        
    }
    
    
    @IBAction func savePressed(sender: AnyObject) {
        
        
       // [self.navigationController popToRootViewControllerAnimated(NO)];
    }
    
    
}
