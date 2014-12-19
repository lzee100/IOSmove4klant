//
//  LogIn.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 05-12-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit
import Foundation

class LogIn: UIViewController, UITextFieldDelegate {
    @IBOutlet var editText_UserName: UITextField!
    @IBOutlet var editText_Password: UITextField!
    @IBOutlet var button_Login: UIButton!
    @IBOutlet var button_signUp: UIButton!
    @IBOutlet var label_welcomeByThe: UILabel!
    @IBOutlet var label_IJzerWinkelApp: UILabel!
    var logInCorrect = false
    
    var keyboardUp: Bool = false
    
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    var container: UIView = UIView()
    var loadingView: UIView = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        skipIfLoggedIn()
        
        self.navigationController?.navigationBar.hidden = true
        // Do any additional setup after loading the view.
        self.editText_UserName.delegate = self
        self.editText_Password.delegate = self
     
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
        loadingView.frame.size.height / 2);
        actInd.hidesWhenStopped = true
        actInd.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        
        
    }
    
    @IBAction func logInPressed(sender: AnyObject) {
        logIn(sender)
    }
    
    func loginuser(sender: AnyObject, waarde: Int)
    {
//        let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("Home") as Home
//        //vc.user = user
//        self.showViewController(vc, sender: sender)
       // println(NSThread.isMainThread())
        dispatch_sync(dispatch_get_main_queue()){
           // println(NSThread.isMainThread())
        self.performSegueWithIdentifier("Home", sender: self)
        }
    }
    
    func logIn(sender : AnyObject) {
        let userName = editText_UserName.text
        let password = editText_Password.text
        if userName == "" {
            
            //actInd.stopAnimating()
            //container.removeFromSuperview()
            
//            actInd.removeFromSuperview()
//            loadingView.removeFromSuperview()
//            container.removeFromSuperview()
//            self.container.removeFromSuperview()
            //self.container.hidden = true
            var alert = UIAlertController(title: "Leeg veld", message: "Vult u alstublieft iets in bij gebruikersnaam.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            //actInd.stopAnimating()
            //self.container.removeFromSuperview()
        } else if password == "" {
            //self.actInd.stopAnimating()
           // self.container.removeFromSuperview()
            var alert = UIAlertController(title: "Leeg veld", message: "Vult u alstublieft iets in bij wachtwoord.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
           // actInd.stopAnimating()
           // self.container.removeFromSuperview()
        } else {
            self.view.addSubview(container)
             actInd.startAnimating()
            container.hidden = false
            
            
            ServerRequestHandler.logIn(userName, password: password, responseMain: { (success : String, message : String, error : NSError!) -> () in
                dispatch_sync(dispatch_get_main_queue()){
                    self.actInd.stopAnimating()
                    self.container.hidden = true
                    self.container.removeFromSuperview()
                }
                let successR = success.toInt()
                
                if successR == 0 {
                    
                    dispatch_sync(dispatch_get_main_queue()){
                        self.container.hidden=true
                        var alert = UIAlertController(title: "Onjuiste inloggegevens", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        self.container.removeFromSuperview()
                    }
                    
                } else if successR == 1 {
                   
                    //self.actInd.stopAnimating()
                    //self.container.removeFromSuperview()
                    //self.logInCorrect = true
                    //self.container.removeFromSuperview()
                    DataHandler.updateAll()
                    DataHandler.storeLikesFromServerLocally(DataHandler.getUserID())
                    
                    dispatch_sync(dispatch_get_main_queue()){
                        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                        appDelegate.logIn = true
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                   
                }
                var alert = UIAlertController(title: "Onjuiste inloggegevens", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
              
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        hideKeyBoardIfShown()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        skipIfLoggedIn()

    }
    
    
    // keyboard behavior
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.editText_Password.resignFirstResponder()
        self.editText_UserName.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.editText_UserName.resignFirstResponder()
        self.editText_Password.resignFirstResponder()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    func keyboardWillShow(sender: NSNotification) {
        if !keyboardUp{
        var info = sender.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        self.view.frame.origin.y-=keyboardFrame.size.height - 10
        
          keyboardUp = true
        }
    }
    func keyboardWillHide(sender: NSNotification) {
        if keyboardUp{
        var info = sender.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        self.view.frame.origin.y+=keyboardFrame.size.height - 10
          keyboardUp = false
        }
    }
    
    func hideKeyBoardIfShown(){
        if keyboardUp == true{
            for txt: AnyObject in self.view.subviews{
                if txt.isKindOfClass(UITextField) && txt.isFirstResponder(){
                    txt.resignFirstResponder()
                }
            }
        }
    }
    
// rotate loading indicator when orientation changed
   override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    coordinator.animateAlongsideTransition(nil, completion: { (control: UIViewControllerTransitionCoordinatorContext!) -> Void in
                 self.container = UIView()
                 self.container.frame = self.view.frame
                 self.container.center = self.view.center
                 self.container.backgroundColor = self.UIColorFromHex(0xffffff, alpha: 0.3)
        
                 self.container.frame = self.view.frame
                 self.container.center = self.view.center
                 self.container.backgroundColor = self.UIColorFromHex(0xffffff, alpha: 0.3)
        
                 self.loadingView = UIView()
                 self.loadingView.frame = CGRectMake(0, 0, 80, 80)
                 self.loadingView.center = self.view.center
                 self.loadingView.backgroundColor = self.UIColorFromHex(0x444444, alpha: 0.7)
                 self.loadingView.clipsToBounds = true
                 self.loadingView.layer.cornerRadius = 10
                 self.actInd  = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
        
                 self.actInd.center = CGPointMake(self.loadingView.frame.size.width / 2,
                 self.loadingView.frame.size.height / 2);
                 self.actInd.hidesWhenStopped = true
                 self.actInd.backgroundColor = self.UIColorFromHex(0xffffff, alpha: 0.3)
                 self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
                 self.loadingView.addSubview(self.actInd)
                 self.container.addSubview(self.loadingView)
    })
    
    
    }
    
    func skipIfLoggedIn(){
        var alert = UIAlertController(title: "email:", message: DataHandler.getUserFromDB().email, preferredStyle: UIAlertControllerStyle.Alert)

        if DataHandler.getUserFromDB().email != nil{
            DataHandler.updateAll()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
       
    }
    
    
}
