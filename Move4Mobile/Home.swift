//
//  Home.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit
import CoreData

class Home: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet var settings: UIBarButtonItem!
    @IBOutlet var label_ijzerhandel: UILabel!
    var actInd : UIActivityIndicatorView?
    
    var products = [NSManagedObject]()
    var uploadimage :UIImage = UIImage()
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        var user = DataHandler.getUserFromDB()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.user = user
        if (user.email != nil){
        appDelegate.logIn = true
        }
        if user.email == nil {
        let nav = appDelegate.nav
        let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let vc  = storyboard.instantiateViewControllerWithIdentifier("navLogIn") as UINavigationController
            
        nav?.presentViewController(vc, animated: true, completion: nil)
        }
    }
}
