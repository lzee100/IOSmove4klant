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
    @IBOutlet weak var button_checkFunctions: UIButton!
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
        if user.userID == nil {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let nav = appDelegate.nav
        let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let vc  = storyboard.instantiateViewControllerWithIdentifier("navLogIn") as UINavigationController
            
        nav?.presentViewController(vc, animated: true, completion: nil)
        }
    }
}
