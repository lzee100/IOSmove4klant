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
        println("this user likes: ")
        for c:Category in cats{
            println(c.toString())
        }
        
        
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
            
        })
        
        //uploadimage=image
        var imagedata = UIImagePNGRepresentation(image)
        let base64String = imagedata.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
   
        //println(base64String.description)
        
        var baseimage = "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TUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIj4KICAgICAgICAgPHRpZmY6UmVzb2x1dGlvblVuaXQ+MTwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICAgICAgICAgPHRpZmY6Q29tcHJlc3Npb24+NTwvdGlmZjpDb21wcmVzc2lvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzI8L3RpZmY6WFJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgICAgIDx0aWZmOllSZXNvbHV0aW9uPjcyPC90aWZmOllSZXNvbHV0aW9uPgogICAgICAgICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+NTg8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogICAgICAgICA8ZXhpZjpDb2xvclNwYWNlPjE8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjU4PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgICAgPGRjOnN1YmplY3Q+CiAgICAgICAgICAgIDxyZGY6QmFnLz4KICAgICAgICAgPC9kYzpzdWJqZWN0PgogICAgICAgICA8eG1wOk1v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"
        
        

        //println(baseimage)
        //dispatch_sync(dispatch_get_main_queue()){
        //ServerRequestHandler.uploadImage(DataHandler.getUserID(), image: baseimage)
        uploadimage(DataHandler.getUserID(), image: base64String)
        
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
