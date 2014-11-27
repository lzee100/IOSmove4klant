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

        //allCategories.append("spijkers")
        //allCategories.append("verf")
        likes.append("0")
        likes.append("1")
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
        
        let id = "likedCategoriesCell"
        var cell : LikedCategoriesCell? = tableView.dequeueReusableCellWithIdentifier(id) as LikedCategoriesCell? //or your custom class
        
        if (cell == nil) {
            cell = tableView.dequeueReusableCellWithIdentifier(id) as LikedCategoriesCell!
        }
        
        cell!.label_category.text = likes[indexPath.row]
        if (savedLikes[indexPath.row] == "0"){
            cell!.switch_like.setOn(false, animated: true)
        } else {
            cell!.switch_like.setOn(true, animated: true)
        }
        cell!.switch_like.addTarget(self, action:"switchChanged:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell!
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var cell : LikedCategoriesCell =  tableView.cellForRowAtIndexPath(indexPath) as LikedCategoriesCell
//        if (cell.switch_like.on){
//            let alert = UIAlertView()
//            alert.title = "Switch"
//            alert.message = "Switch is on"
//            alert.addButtonWithTitle("Ok")
//            alert.show()
//            selectedLikes[indexPath.row] = "1"
//        }
//        else {
//            let alert = UIAlertView()
//            alert.title = "Title"
//            alert.message = "Switch if off"
//            alert.addButtonWithTitle("Ok")
//            alert.show()
//            selectedLikes[indexPath.row] = "0"
//        }
//        
//    }
    
    func switchChanged (sender : UISwitch) {
        let cell : UITableViewCell = sender.superview!.superview as UITableViewCell
        
        
        let indexPath : NSIndexPath = tableLikes.indexPathForCell(cell)!
//        let alert = UIAlertView()
//        alert.title = "Title"
//        alert.message = "You changed cell " + String(indexPath.row)
//        alert.addButtonWithTitle("Ok")
//        alert.show()
        if (selectedLikes[indexPath.row] == "1"){
        selectedLikes[indexPath.row] = "0"
        }
        else{
            selectedLikes[indexPath.row] = "1"
        }
    }
    
    @IBAction func save(sender: AnyObject) {
        var categoriesToSave = ""
        var i = 0
        for number in selectedLikes {
            if (number == "1"){
            categoriesToSave += likes[i]
            }
            i++
        }
        let alert = UIAlertView()
                alert.title = "Title"
        alert.message = "To save: " + categoriesToSave
                alert.addButtonWithTitle("Ok")
                alert.show()

    }
    

}
