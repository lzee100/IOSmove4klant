//
//  SignUp.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 17-12-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class SignUp: UIViewController {

    @IBOutlet var editText_firstName: UITextField!
    @IBOutlet var editText_lastName: UITextField!
    @IBOutlet var editText_email: UITextField!
    @IBOutlet var editText_password: UITextField!
    @IBOutlet var button_signUp: UIButton!
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    //var backbutton : UIBarButtonItem!
    var container: UIView = UIView()
    var keyboardUp: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        // Do any additional setup after loading the view.
        
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        //var backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "hideKeyBoardIfShown")
        //self.navigationItem.backBarButtonItem.action="hideKeyBoardIfShown:"
        self.navigationItem.backBarButtonItem?.action="hideKeyBoardIfShown:"
        
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
        
        var loadingView: UIView = UIView()
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
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUpPressed(sender: AnyObject) {
        
        actInd.startAnimating()
        self.signUp(sender)
//        ServerRequestHandler.signUp(<#name: String#>, email: <#String#>, password: <#String#>, response: <#((HTTPResponse) -> Void)!##(HTTPResponse) -> Void#>)(userID, respone: {(response: HTTPResponse) -> Void in
//            if let data = response.responseObject as? NSData {
//                let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
//                var sep = str.componentsSeparatedByString("<")
//                var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
//                
//                var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
//                
//                if let json = allContacts as? Dictionary<String, Array<Int>> {
//                    
//                    returnvalue = json["returnvalue"]!
//                    
//                    var cats:[NSManagedObject] = self.getManagedObjects("Categories")
//                    
//                    
//                    for i : Int in returnvalue{
//                        for category : NSManagedObject in cats{
//                            if category.valueForKey("id") as Int==i{
//                                category.setValue(1, forKey: "liked")
//                            }
//                        }
//                    }
//                }
//            }
//            
//        })

        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func signUp(sender : AnyObject) {
        let firstName = editText_firstName.text
        let lastName = editText_lastName.text
        let password = editText_password.text
        let email = editText_email.text
        
        var errorMessage : String = ""
        if firstName == "" {
            showAlert("Leeg veld", message: "vul een naam in")
        }
        else if lastName == "" {
            showAlert("Leeg veld", message: "vul een achternaam in")
        }
        else if password == "" {
            showAlert("Leeg veld", message: "vul een wachtwoord in")
        } else if email == "" {
            showAlert("Leeg veld", message: "vul een email in")
        } else {
            ServerRequestHandler.signUp(firstName, lastname: lastName, email: email, password: password, response: { (httpResponse: HTTPResponse) -> Void in
                if let data = httpResponse.responseObject as? NSData {
                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
                    //var sep = str.componentsSeparatedByString("<")
                    var henk = str.dataUsingEncoding(NSUTF8StringEncoding)
                    var allData: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
                    if let json = allData as? Dictionary<String, AnyObject>{
                        if json["error"] != nil{
                            var errorCode = json["error"] as Int
                            if errorCode == 0 {
                                if json["success"] != nil {
                            let succes = json["success"] as Int
                            if succes == 1{
                                if json["user"] != nil{
                                    let dictUser : AnyObject = json["user"]!
                                        if let user  = dictUser as? Dictionary<String, AnyObject>{
                                            let userFirstName : String = user["fname"] as String
                                            let userLastName : String = user["lname"]as String
                                            let userID : String = user["customerID"]as String
                                            let userEmail : String = user["email"]as String
                                            //let profileImage : String = user["profileImage"] as String
                                    
//                                            if !profileImage.isEmpty{
//                                                DataHandler.saveUserWithImage(userID.toInt()!, firstname: userFirstName, lastname: userLastName, email: userEmail, image: ImageHandler.base64ToUIImage(profileImage))
//                                                self.dismissViewControllerAnimated(true, completion: nil)
//
//                                            }
//                                            else{
                                                DataHandler.updateAll()
                                                DataHandler.saveUser(userID.toInt()!, firstname: userFirstName, lastname: userLastName, email: userEmail)
                                                let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                                                appDelegate.logIn = true
                                                self.dismissViewControllerAnimated(true, completion: nil)

                                            //}
                                        }
                                }else{
                                    errorMessage = "Gebruiker is niet juist doorgestuurd"
                                }
                            }
                            else{
                                errorMessage = "Controleer uw gegevens en probeer het later nogmaals"
                            }
                        }
                            }
                            else if errorCode > 0{
                                errorMessage = json["error_msg"] as String
                            }
                        }
                    }
                    else{
                       errorMessage = "Controleer uw gegevens en probeer het later nogmaals"
                    }
                }
                else{
                     errorMessage = "Controleer uw gegevens en probeer het later nogmaals"
                }
                if errorMessage != "" {
                    self.showAlert("Server Error", message: errorMessage)
                }
            })
            
           


            
        }
    }
    
    func showAlert(title: String, message: String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        actInd.stopAnimating()
        self.container.removeFromSuperview()
    }
    
    // keyboard behavior
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.editText_firstName.resignFirstResponder()
        self.editText_lastName.resignFirstResponder()
        self.editText_email.resignFirstResponder()
        self.editText_password.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.editText_firstName.resignFirstResponder()
        self.editText_lastName.resignFirstResponder()
        self.editText_email.resignFirstResponder()
        self.editText_password.resignFirstResponder()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func keyboardWillShow(sender: NSNotification) {
        var info = sender.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        //self.view.frame.origin.y -= 200
        self.view.frame.origin.y-=keyboardFrame.size.height - 10
        keyboardUp = true
    }
    func keyboardWillHide(sender: NSNotification) {
        var info = sender.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        //self.view.frame.origin.y += 200
        self.view.frame.origin.y+=keyboardFrame.size.height - 10
        keyboardUp = false
    }
    
    func hideKeyBoardIfShown(){
        if keyboardUp == true{
        //self.view.frame.origin.y += 200
            
            for txt: AnyObject in self.view.subviews{
                if txt.isKindOfClass(UITextField) && txt.isFirstResponder(){
                    txt.resignFirstResponder()
                }
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }

}
