//
//  EditAccount.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class EditAccount: UIViewController {
    @IBOutlet var button_save: UIBarButtonItem!
    @IBOutlet var button_changeLikes: UIButton!
    @IBOutlet var label_titleEditAccountinfo: UILabel!
    @IBOutlet var imageView_profilePicture: UIImageView!
    @IBOutlet var label_firstName: UILabel!
    @IBOutlet var label_sirName: UILabel!
    @IBOutlet var label_email: UILabel!
    @IBOutlet var textinput_firstName: UITextField!
    @IBOutlet var textinput_sirName: UITextField!
    @IBOutlet var textinput_email: UITextField!
    @IBOutlet var label_titleLikes: UILabel!
    @IBOutlet var tableLikes: UITableView!
    var likes = [String]()
    
    // dummy info
    var name =      "Leo"
    var sirName =   "van der Zee"
    var email =     "lzee100@gmail.com"
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        likes.append("spijkers")
        likes.append("verf")
        
        textinput_firstName.placeholder = name
        textinput_sirName.placeholder = sirName
        textinput_email.placeholder = email
        
        
        var image = UIImage(named: "emptyprofile")
        imageView_profilePicture.image = image

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
        
        let id = "editAccountCell"
        var cell : EditAccountCell? = tableView.dequeueReusableCellWithIdentifier(id) as EditAccountCell? //or your custom class
        
        if (cell == nil) {
            cell = tableView.dequeueReusableCellWithIdentifier(id) as EditAccountCell!
        }
        
        cell!.label_category.text = likes[indexPath.row]
        
        return cell!
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
