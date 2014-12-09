//
//  LogIn.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 05-12-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class LogIn: UIViewController, UITextFieldDelegate {
    @IBOutlet var editText_UserName: UITextField!
    @IBOutlet var editText_Password: UITextField!
    @IBOutlet var button_Login: UIButton!
    @IBOutlet var button_signUp: UIButton!
    @IBOutlet var label_welcomeByThe: UILabel!
    @IBOutlet var label_IJzerWinkelApp: UILabel!
    var user : User?
    var logInCorrect = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.editText_UserName.delegate = self
        self.editText_Password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInPressed(sender: AnyObject) {
        self.logIn(sender)
    }
    
    @IBAction func signUpPressed(sender: AnyObject) {
        ServerRequestHandler.logIn("sanderwubs@gmail.com", password: "testr") { (success : String, message : String, user : User?, error) -> () in
            self.performSegueWithIdentifier("Home", sender: nil)
        }
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.editText_Password.resignFirstResponder()
        self.editText_UserName.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.editText_UserName.resignFirstResponder()
        self.editText_Password.resignFirstResponder()
    }
    
    
    func logIn(sender : AnyObject) {
        let userName = editText_UserName.text
        let password = editText_Password.text
        if userName == "" {
            var alert = UIAlertController(title: "Leeg veld", message: "Vult u alstublieft iets in bij gebruiktsnaam.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else if password == "" {
            var alert = UIAlertController(title: "Leeg veld", message: "Vult u alstublieft iets in bij wachtwoord.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            ServerRequestHandler.logIn(userName, password: password, responseMain: { (success : String, message : String, user : User?, error : NSError!) -> () in
                let successR = success.toInt()
                if successR == 0 {
                    var alert = UIAlertController(title: "Onjuiste inloggegevens", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else if successR == 1 {
                    self.user = user
                    self.logInCorrect = true
                    self.performSegueWithIdentifier("Home", sender: nil)
                    
                    //let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                    //let vc = storyboard.instantiateViewControllerWithIdentifier("Home") as Home
                    //vc.user = user
                    //self.presentViewController(vc, animated: true, completion: nil)
                }
            })
        }
    }


}
