//
//  Home.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class Home: UIViewController {
    @IBOutlet var settings: UIBarButtonItem!
    @IBOutlet var label_ijzerhandel: UILabel!
    @IBOutlet weak var button_checkFunctions: UIButton!
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        println(user?.getUserID())
        ServerRequestHandler.logIn("sanderwubs@gmail.com", password: "testr") { (success : String, message : String, user : User?, error) -> () in
            self.user = user
            println(user!.getUserID())
        }
    }
    

    @IBAction func checkFunctionPressed(sender: AnyObject) {
        
        ServerRequestHandler.logIn("sanderwubs@gmail.com", password: "testr") { (success : String, message : String, user : User?, error) -> () in
            println("success code :\(success)")
            println(message)
        }
        //ServerRequestHandler().getAllProducts()
    }

    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToSettings" {
            
        }
    }
    */
}
