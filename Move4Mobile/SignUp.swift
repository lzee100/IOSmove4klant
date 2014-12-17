//
//  SignUp.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 17-12-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class SignUp: UIViewController {

    @IBOutlet var editText_name: UITextField!
    @IBOutlet var editText_email: UITextField!
    @IBOutlet var editText_password: UITextField!
    @IBOutlet var button_signUp: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUpPressed(sender: AnyObject) {
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
