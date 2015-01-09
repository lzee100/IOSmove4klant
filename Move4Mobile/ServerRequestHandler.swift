//
//  ServerRequestHandler.swift
//  Move4Klant
//
//  Created by Sander Wubs on 26/11/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import CoreData


public class ServerRequestHandler: NSObject {
    
    //Get information from server
    
    func getAllCategories() -> [Category] {
        
        var returnarray = [Category]()
        
        //specify URL of API to get data from
        let url=NSURL(string: Config().CATEGORYURL)
        
        //get data from server
        let allContactsData=NSData(contentsOfURL:url!)
        
        //put data in string and remove any weird automatically added hosting message
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        var sep = str.componentsSeparatedByString("<")
        var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
        
        //string to object
        var allCategories: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
        
        //loop trough json
        if let json = allCategories as? Array<AnyObject> {
            
            for index in 0...json.count-1 {
                
                let beacon : AnyObject? = json[index]
                
                let collection = beacon! as Dictionary<String, String>
                
                var catid : String  = collection["id"]!
                let catname : String = collection["name"]!
                
                //make category from item in json
                let catobj : Category = Category(ID: catid.toInt()!, name: catname)
                //append to returnarray
                returnarray.append(catobj)
            }
        }
        return returnarray
    }
    
    func getAllOffers() -> [Offer]{
        var returnarray = [Offer]()
        
        //specify URL of API to get data from
        let url=NSURL(string: Config().GETALLOFFERS)
         //get data from server
        let allContactsData=NSData(contentsOfURL:url!)
        
        //put data in string and remove any weird automatically added hosting message
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        var sep = str.componentsSeparatedByString("<")
        var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
        
        //string to object
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
        
        //loop trough json
        if let json = allContacts as? Array<AnyObject> {
            
            for index in 0...json.count-1 {
                
                let beacon : AnyObject? = json[index]
                
                let collection = beacon! as Dictionary<String, AnyObject>
                
                var offerid : String  = collection["id"] as String
                var offercat : String
                var temp : AnyObject = collection["category"]!
                if temp.description == "<null>"{
                    offercat = "99"
                }
                else{
                    //productobj.categoryID = collection["categoryID"] as? Int
                    offercat = collection["category"] as String
                }
                
                
                //let offercat : String = collection["category"] as String
                let offerdesc : String = collection["description"] as String
                
                let beaconobj : Offer = Offer(ID: offerid.toInt()!, categoryID: offercat.toInt()!, offerdescription: offerdesc)
                
                
                if collection["image"] != nil{
                    var img : String = collection["image"] as String
                    if img != "none" && img != "null" && img != ""  {
                        beaconobj.setImagePath(img)
                    }
                }
                
                //println(beaconobj.toString())
                returnarray.append(beaconobj)
            }
        }
        return returnarray
    }
    
    func getAllBeacons() -> [Beacon]{
        var returnarray = [Beacon]()
        
        //Get data from server
        let url=NSURL(string: Config().GETALLBEACONS)
        let allContactsData=NSData(contentsOfURL:url!)
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        var sep = str.componentsSeparatedByString("<")
        var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
        
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
        
        //loop through json
        if let json = allContacts as? Array<AnyObject> {
            
            for index in 0...json.count-1 {
                
                let beacon : AnyObject? = json[index]
                
                let collection = beacon! as Dictionary<String, String>
                
                //get values from item in json
                var beaconid : String  = collection["beaconID"]!
                let beaconminor : String = collection["minor"]!
                let beaconmajor : String = collection["major"]!
                let beaconproductid : String = collection["productID"]!
                let beaconofferid : String = collection["offerID"]!
                
                //make beacon object
                let beaconobj : Beacon = Beacon(ID: beaconid.toInt()!, productID: beaconproductid.toInt()!, offerID: beaconofferid.toInt()!, major: beaconmajor.toInt()!, minor: beaconminor.toInt()!)
                //println(beaconobj.toString())
                returnarray.append(beaconobj)
            }
        }
        return returnarray
    }
    
    func getAllProducts() -> [Product]{
        var returnarray = [Product]()
        let url=NSURL(string: Config().GETALLPRODUCTS)
        let allContactsData=NSData(contentsOfURL:url!)
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        var sep = str.componentsSeparatedByString("<")
        var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
        
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
        
        if let json = allContacts as? Array<AnyObject> {
            
            for index in 0...json.count-1 {
                
                let beacon : AnyObject? = json[index]
                // println(beacon)
                let collection = beacon! as Dictionary<String, AnyObject>
                
                var productid : String  = collection["id"] as String
                let productname : String = collection["name"]as String
                // println(collection["categoryID"])
                var temp: AnyObject? = collection["categoryID"]
                
                
                
                let productdesc : String = collection["description"]as String
                
                let productobj : Product = Product(ID: productid.toInt()!, productdescription: productdesc, name: productname)
                
                var productcat : Int
                if temp?.description == "<null>"{
                }
                else{
                    productobj.categoryID = collection["categoryID"] as? Int
                }
                
                if collection["image"] != nil{
                    var img : String = collection["image"] as String
                    if img != "none" && img != "null" && img != ""  {
                        productobj.setImagePath(img)
                    }
                }
                
                
                //println(beaconobj.toString())
                returnarray.append(productobj)
            }
        }
        return returnarray
    }
    
    
    
    
    class func getAllImages(){
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //Get data from server
        let url=NSURL(string: Config().GETIMAGES)
        let allContactsData=NSData(contentsOfURL:url!)
        
        //parse data
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        var henk = str.dataUsingEncoding(NSUTF8StringEncoding)
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)

        //loop through json
        if let json = allContacts as? Array<AnyObject> {
            
            for index in 0...json.count-1 {
                var path : String = json[index].valueForKey("path") as String
                
                var products = DataHandler.getManagedObjects("Product")
                var offers = DataHandler.getManagedObjects("Offer")
                
                //get base64 string of image
                var base64 = json[index]["image"] as NSString
                
                //check if the image belongs to a product. if so, add the image to this product
                for m : NSManagedObject in products{
                    var mpath : String = m.valueForKey("serverimagepath") as String
                    if path == mpath{
                        if base64 != ""{
                            var image = ImageHandler.base64ToUIImage(base64)
                            m.setValue(UIImagePNGRepresentation(image), forKey: "image")
                        }
                    }
                }
                
                //check if the image belongs to a offer. if so, add the image to this offer
                for m : NSManagedObject in offers{
                    if m.valueForKey("serverimagepath") != nil{
                        var mpath : String = m.valueForKey("serverimagepath") as String
                        if path == mpath{
                            if base64 != ""{
                                var image = ImageHandler.base64ToUIImage(base64)
                                m.setValue(UIImagePNGRepresentation(image), forKey: "image")
                            }
                        }
                    }
                }
                
                
            }
            
            var error: NSError?
            if !managedContext.save(&error) {
            }
        }
        else{
        }
    }
    
    class func getImages() -> Dictionary<String, UIImage>{
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        
        
        let url=NSURL(string: Config().GETIMAGES)
        let allContactsData=NSData(contentsOfURL:url!)
        
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        
        var henk = str.dataUsingEncoding(NSUTF8StringEncoding)
        
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
        
        var returnvalue = Dictionary<String, UIImage>()
        
        if var json = allContacts as? Array<AnyObject> {
            
            for index in 0...json.count-1 {
                var imgpath = json[index]["path"] as String
                var image = json[index]["image"] as NSString
                var decodedimage = ImageHandler.base64ToUIImage(image)
                returnvalue.updateValue(decodedimage, forKey: imgpath)
            }
        }
        return returnvalue
    }
    
    
    
    
    
    //user functions
    
    class func checkinout(userID: Int){
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": userID]
        request.POST(Config().CHECKINURL, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                
        })
    }
    
    class func checkinStatus(userID: Int, responseMain:(success : Bool, error:NSError!) ->()){
        var bool = false
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": userID]
        
        request.POST(Config().CHECKINGSTATUS, parameters: params, success: {(response: HTTPResponse) in
            
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var sep = str.componentsSeparatedByString("<")
                var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
                
                var allContacts = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil) as NSDictionary
                // if there is an user, login went correct
                if ((allContacts["returnvalue"]) != nil) {
                    if let returnBool = allContacts["returnvalue"] as? Int {
                        if returnBool == 1 {
                            bool = true
                        }
                    }
                    
                }
            }
            responseMain(success: bool, error: nil)
            
            },failure: {(error: NSError, response: HTTPResponse?) in
                responseMain(success: bool, error: error)
        })
        
        
    }
    
    class func uploadLikes(customerID: Int, categories: [Int]){
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": customerID, "categories":  categories.description]
        request.POST(Config().EDITLIKESURL, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
        })
    }
    
    class func uploadUserInfo(customerID: Int, name: String, lastname: String, email: String){
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": customerID, "name":  name, "email": email, "lastname": lastname]
        request.POST(Config().EDITUSER, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
        })
    }
    
    class func getLikes(userID: Int, respone: ((HTTPResponse) -> Void)!) -> Array<Int>{
        var request = HTTPTask()
        var returnvalue = Array<Int>()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": userID]
        request.POST(Config().GETLIKESURL, parameters: params, success: respone ,failure: {(error: NSError, response: HTTPResponse?) in
        })
        return returnvalue
        
    }
    
    class func uploadImage(customerID: Int, base64image: String){
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": customerID, "image": base64image]
        print("posted customerID :")
        println(toString(customerID))
        request.POST(Config().UPLOADIMAGE, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response upload image: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
        })
    }
    
    class func logIn (email : String, password : String, responseMain: (success : String, message : String, error:NSError!) ->()){
        //let queue = dispatch_get_main_queue()
        
        //dispatch_async(queue, {
        var message : String!
        var success : String!
        var error : NSError?
        var user : User?
        
        var request = HTTPTask()
        var returnvalue = ""
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["tag" : "login", "email" : email, "password" : password]
        request.POST(Config().LOGINURL, parameters: params, success: {(response: HTTPResponse) in
            
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var sep = str.componentsSeparatedByString("<")
                var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
                
                var allContacts = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil) as NSDictionary
                // if there is an user, login went correct
                if ((allContacts["user"]) != nil) {
                    let dicUser : AnyObject = allContacts["user"]!
                    if let collection = dicUser as? Dictionary<String, AnyObject> {
                        let userFirstName : String = collection["fname"] as String
                        let userLastName : String = collection["lname"]as String
                        let userID : String = collection["customerID"]as String
                        let userEmail : String = collection["email"]as String
                        let profileImage : String = collection["profileImage"] as String
                        //println("gedownloade user")
                        //println(collection.description)
                        //println("")
                        if profileImage != ""{
                            var decodedimage = ImageHandler.base64ToUIImage(profileImage)
                            DataHandler.saveUserWithImage(userID.toInt()!, firstname: userFirstName, lastname: userLastName, email: userEmail, image: decodedimage)
                        }
                        else{
                            DataHandler.saveUser(userID.toInt()!, firstname: userFirstName, lastname: userLastName, email: userEmail)
                        }
                        message = ""
                        success = "1"
                    }
                    // if there was no user object, give result message
                } else {
                    if let value : AnyObject = allContacts["success"] {
                        let string : String = "\(value)"
                        success = string
                    }
                    if let value : AnyObject = allContacts["error_msg"]{
                        let string : String = "\(value)"
                        message = string
                    }
                }
                responseMain(success: success, message: message, error: nil)
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                responseMain (success: success, message: message, error: error)
        })
    }
    
    class func signUp(firstname: String, lastname: String, email: String, password: String, response: ((HTTPResponse) -> Void)!){
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["tag" : "register", "email" : email, "password" : password, "fname" : firstname, "lname" : lastname ]
        request.POST(Config().REGISTERURL, parameters: params, success: response ,failure: {(error: NSError, response: HTTPResponse?) in
        })
    }
    
    
    
    
    //other
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true : false
    }
    
    
    
    
    
    //    func login2(email: String, password: String, respone: ((HTTPResponse) -> Void)!) -> User{
    //        var request = HTTPTask()
    //        var returnvalue = User()
    //        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
    //        let params: Dictionary<String,AnyObject> = ["tag": "login", "email": email, "password": password]
    //        request.POST(Config().LOGINURL, parameters: params, success: respone ,failure: {(error: NSError, response: HTTPResponse?) in
    //        })
    //        return returnvalue
    //
    //    }
    //
    //    class func uploadImage2(customerID: Int, image: String, respone: ((HTTPResponse) -> Void)!){
    //        var request = HTTPTask()
    //        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
    //        let params: Dictionary<String,AnyObject> = ["customerID": customerID, "image": image]
    //        request.POST(Config().UPLOADIMAGE, parameters: params, success: respone,failure: {(error: NSError, response: HTTPResponse?) in
    //
    //        })
    //    }
    //
    
    //    class func getLikes3 (userID : Int, responseMain: (Array<Int>!, error:NSError!) ->()){
    //        //let queue = dispatch_get_main_queue()
    //
    //        //dispatch_async(queue, {
    //
    //            var error : NSError?
    //
    //            var request = HTTPTask()
    //            var returnvalue = Array<Int>()
    //            //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
    //            let params: Dictionary<String,AnyObject> = ["customerID": userID]
    //            request.POST(Config().GETLIKESURL, parameters: params, success: {(response: HTTPResponse) in
    //                if let data = response.responseObject as? NSData {
    //                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
    //                    var sep = str.componentsSeparatedByString("<")
    //                    var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
    //
    //                    var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
    //
    //                    if let json = allContacts as? Dictionary<String, Array<Int>> {
    //
    //                        returnvalue = json["returnvalue"]!
    //
    //                        for i : Int in returnvalue{
    //                            println(i)
    //                        }
    //                    }
    //                    responseMain(returnvalue, error: nil)
    //                }
    //                },failure: {(error: NSError, response: HTTPResponse?) in
    //            })
    //        //})
    //
    //    }
    //
}
