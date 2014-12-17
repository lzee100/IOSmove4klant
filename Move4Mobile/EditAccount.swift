//
//  EditAccount.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class EditAccount: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
    var likedCategories = [Category]()
    
    var imagePicker = UIImagePickerController()
    var user : User = User()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = DataHandler.getUserFromDB()
        
        likedCategories = DataHandler.getLikedCategoriesFromDB()
        tableLikes.reloadData()
        
        textinput_firstName.placeholder = user.name!
        textinput_sirName.placeholder = user.lastName!
        textinput_email.placeholder = user.email!
        
        imageView_profilePicture.image = user.image
        self.imageView_profilePicture.layer.cornerRadius = 20;
        self.imageView_profilePicture.clipsToBounds = true;
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        
        imageView_profilePicture.addGestureRecognizer(tapGesture)
        imageView_profilePicture.userInteractionEnabled = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tapGesture(gesture: UIGestureRecognizer) {
        
        if let imageView = gesture.view as? UIImageView {  // if you subclass UIImageView
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
                println("")
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
                self.imagePicker.allowsEditing = true
                
                self.presentViewController(self.imagePicker, animated: true, completion: nil)}
            
        }
    }
    
    
    // table functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (likedCategories.count != 0)
        {
            return likedCategories.count
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
        
        cell!.label_category.text = likedCategories[indexPath.row].name!
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
//        if (segue.identifier == "saveManageAccount"){
//            var name = textinput_firstName.text
//            var lastname = textinput_sirName.text
//            var email = textinput_email.text
//            
//            if (name == "") {
//                name = textinput_firstName.placeholder!
//            }
//            if (lastname == ""){
//                lastname = textinput_sirName.placeholder!
//            }
//            if (email == ""){
//                email = textinput_email.placeholder!
//            }
//            
//            let newUser : User = User()
//            newUser.createUserWithName(name, uLastName: lastname, uEmail: email)
//            let destinationVC = segue.destinationViewController as ManageAccount
//            destinationVC.user = newUser
//        }
        if (segue.identifier == "changeLikedCategories"){
            let destinationVC = segue.destinationViewController as LikedCategories
        }
    }
    
    @IBAction func save(sender: AnyObject) {
        var name = textinput_firstName.text
        var lastname = textinput_sirName.text
        var email = textinput_email.text
        
        if (name == "") {
            name = textinput_firstName.placeholder!
        }
        if (lastname == ""){
            lastname = textinput_sirName.placeholder!
        }
        if (email == ""){
            email = textinput_email.placeholder!
        }
        
        let newUser = User(uID: user.getUserID(), uName: name, uLastName: lastname, uEmail: email)
        
        var userToSave = "UserID: \(newUser.getUserID())\nName: \(newUser.name)\nLastName: \(newUser.lastName)\nEmail: \(newUser.email)"
        // go to first screen (Manage Account)
        //self.navigationController?.popToRootViewControllerAnimated(true)
//        let alert = UIAlertView()
//        alert.title = "Title"
//        alert.message = "To save: " + userToSave
//        alert.addButtonWithTitle("Ok")
//        alert.show()
        DataHandler.saveUser(newUser.getUserID(), firstname: newUser.name!, lastname: newUser.lastName!, email: newUser.email!)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        }
    
    
    
    // keyboard behavior
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textinput_firstName.resignFirstResponder()
        self.textinput_sirName.resignFirstResponder()
        self.textinput_email.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.textinput_firstName.resignFirstResponder()
        self.textinput_sirName.resignFirstResponder()
        self.textinput_email.resignFirstResponder()
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
            var resizedImage : UIImage = self.resizeImage(image)
            var imagedata = UIImagePNGRepresentation(resizedImage)
            
            let base64String = imagedata.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
            var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
            actInd.center = self.imagePicker.view.center
            actInd.hidesWhenStopped = true
            actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            self.imagePicker.view.addSubview(actInd)
            actInd.startAnimating()
            
            for m: NSManagedObject in DataHandler.getManagedObjects("User"){
                m.setValue(UIImagePNGRepresentation(image), forKey: "profileImage")
            }
            //println(baseimage)
            //dispatch_sync(dispatch_get_main_queue()){
            //ServerRequestHandler.uploadImage(DataHandler.getUserID(), image: baseimage)
            print("UserID: ")
            println(DataHandler.getUserID())
            self.uploadimage(DataHandler.getUserID(), image: base64String)
            self.imageView_profilePicture.image=image
            
        })
        
        //uploadimage=image
        var imagedata = UIImagePNGRepresentation(image)
        let base64String = imagedata.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
        
        
        //println(base64String.description)
        
        
        
        //}
        
    }
    
    func uploadimage(id:Int , image:String){
        var returnvalue = String()
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
       dispatch_async(dispatch_get_global_queue(priority, 0)) {
//            ServerRequestHandler.uploadImage2(id, image: image, respone: {(response: HTTPResponse) -> Void in
//                
//           })
         ServerRequestHandler.uploadImage(id, image: image)
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
            }
        }

    }
    
    func resizeImage(image :UIImage)->UIImage{
        var newSize:CGSize = CGSize(width: 200,height: 200)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        // image is a variable of type UIImage
        image.drawInRect(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    
}



