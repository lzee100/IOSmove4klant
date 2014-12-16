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
    //var user : User?
    
    var products = [NSManagedObject]()
    var uploadimage :UIImage = UIImage()
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        //println(user?.getUserID())
//        ServerRequestHandler.logIn("sanderwubs@gmail.com", password: "testr") { (success : String, message : String, user : User?, error) -> () in
//            self.user = user
//            println(user!.getUserID())
//        }
        
        var user = DataHandler.getUserFromDB()
        println("logged in as: " + user.name!)
        DataHandler.updateAll()
        DataHandler.storeLikesFromServerLocally(user.userID!)
        
   
    }
    

    


    @IBAction func checkFunctionPressed(sender: AnyObject) {
        
        
        var cats: [Category] = DataHandler.getLikedCategoriesFromDB()
       
        
        
        dispatch_async(dispatch_get_main_queue()) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            println("")
            
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            self.imagePicker.allowsEditing = true
            
                self.presentViewController(self.imagePicker, animated: true, completion: nil)}
            
        }
               // ServerRequestHandler.logIn("sanderwubs@gmail.com", password: "testr") { (success : String, message : String, user : User?, error) -> () in
        //    println("success code :\(success)")
        //    println(message)
        
        
        //}
//        var returnvalue = Array<Int>()
//        
//                ServerRequestHandler().getLikes2(0, respone: {(response: HTTPResponse) -> Void in
//                    if let data = response.responseObject as? NSData {
//                        let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
//                        var sep = str.componentsSeparatedByString("<")
//                        var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
//        
//                        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
//        
//                        if let json = allContacts as? Dictionary<String, Array<Int>> {
//        
//                            returnvalue = json["returnvalue"]!
//                            for i : Int in returnvalue{
//                                println(i)
//                            }
//                        }
//                    }
//                })
//        
//        
//        var category = [NSManagedObject]()
//        
        
        
        //
        //        var products = ServerRequestHandler().getAllProducts()
        //        for offerobj : Product in products{
        //            println(offerobj.toString())
        //        }
        //         var returnvalue = Array<Int>()
        //
        //        ServerRequestHandler().getLikes2(0, respone: {(response: HTTPResponse) -> Void in
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
        //                    for i : Int in returnvalue{
        //                        println(i)
        //                    }
        //                }
        //            }
        //        })
        //
        
        //        let newitem = NSEntityDescription.insertNewObjectForEntityForName("Categories", inManagedObjectContext: self.managedObjectContext!) as Category
        //        newitem.setInfo(0, Name: "spijkers", liked: 0)
        //        presentItemInfo()

    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            var imagedata = UIImagePNGRepresentation(image)
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
            self.uploadimage(DataHandler.getUserID(), image: base64String)
            
        })
        
        //uploadimage=image
        var imagedata = UIImagePNGRepresentation(image)
        let base64String = imagedata.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
   
        
        //println(base64String.description)
        
      
        
        //}
        
    }
   
    func uploadimage(id:Int , image:String){
         var returnvalue = String()
             ServerRequestHandler.uploadImage2(id, image: image, respone: {(response: HTTPResponse) -> Void in
                                if let data = response.responseObject as? NSData {
                                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
                                    var sep = str.componentsSeparatedByString("<")
                                    var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
                                    println(henk)
                                    println()
                                    var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
            
                                    if let json = allContacts as? Dictionary<String, String> {
            
                                        returnvalue = json["returnvalue"]!
                                       println(returnvalue)
                                    }
                                }
                            })
        

    }
  
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToSettings" {
            
        }
    }
    */
}
