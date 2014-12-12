//
//  ServerRequestHandler.swift
//  Move4Klant
//
//  Created by Sander Wubs on 26/11/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit
import Foundation

public class ServerRequestHandler: NSObject {
    
    func getAllCategories() -> [Category] {
        var returnarray = [Category]()
        let url=NSURL(string: Config().CATEGORYURL)
        let allContactsData=NSData(contentsOfURL:url!)
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        var sep = str.componentsSeparatedByString("<")
        var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
        
        var allCategories: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
        
        if let json = allCategories as? Array<AnyObject> {
            
            for index in 0...json.count-1 {
                
                let beacon : AnyObject? = json[index]
                
                let collection = beacon! as Dictionary<String, String>
                
                var catid : String  = collection["id"]!
                let catname : String = collection["name"]!
                
                let catobj : Category = Category(ID: catid.toInt()!, name: catname)
                //println(catobj.toString())
                returnarray.append(catobj)
            }
        }
        return returnarray
        //var request = NSMutableURLRequest(URL:Config().CATEGORYURL)
        
//        var request = HTTPTask()
//        request.GET(Config().CATEGORYURL, parameters: nil, success: {(response: HTTPResponse) in
//            if let data = response.responseObject as? NSData {
//                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
//                NSLog("Categorieen %@", str!)
//            }
//            },failure: {(error: NSError, response: HTTPResponse?) in
//                println("error: \(error)")
//        })
    }
    
    func getAllOffers() -> [Offer]{
        var returnarray = [Offer]()
        let url=NSURL(string: Config().GETALLOFFERS)
        let allContactsData=NSData(contentsOfURL:url!)
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        var sep = str.componentsSeparatedByString("<")
        var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
        
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
        
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
                //println(beaconobj.toString())
                returnarray.append(beaconobj)
            }
        }
        return returnarray
    }

    func getAllBeacons() -> [Beacon]{
        var returnarray = [Beacon]()
        let url=NSURL(string: Config().GETALLBEACONS)
        let allContactsData=NSData(contentsOfURL:url!)
        let str : NSString = NSString(data: allContactsData!, encoding: NSUTF8StringEncoding)!
        var sep = str.componentsSeparatedByString("<")
        var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
        
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
        
        if let json = allContacts as? Array<AnyObject> {
            
            for index in 0...json.count-1 {
                
                let beacon : AnyObject? = json[index]
                
                let collection = beacon! as Dictionary<String, String>
                
                var beaconid : String  = collection["beaconID"]!
                let beaconminor : String = collection["minor"]!
                let beaconmajor : String = collection["major"]!
                let beaconproductid : String = collection["productID"]!
                let beaconofferid : String = collection["offerID"]!
                
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
                
                //println(beaconobj.toString())
                returnarray.append(productobj)
            }
        }
        return returnarray
    }

    //user functions
    
    public func checkinout(userID: Int){
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
    
    public func uploadLikes(customerID: Int, categories: [Int]){
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
    
    class func getLikes(userID: Int, respone: ((HTTPResponse) -> Void)!) -> Array<Int>{
        var request = HTTPTask()
        var returnvalue = Array<Int>()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": userID]
        request.POST(Config().GETLIKESURL, parameters: params, success: respone ,failure: {(error: NSError, response: HTTPResponse?) in
        })
        return returnvalue
        
    }
    
    class func getLikes3 (userID : Int, responseMain: (Array<Int>!, error:NSError!) ->()){
        //let queue = dispatch_get_main_queue()
        
        //dispatch_async(queue, {
        
            var error : NSError?
            
            var request = HTTPTask()
            var returnvalue = Array<Int>()
            //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
            let params: Dictionary<String,AnyObject> = ["customerID": userID]
            request.POST(Config().GETLIKESURL, parameters: params, success: {(response: HTTPResponse) in
                if let data = response.responseObject as? NSData {
                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
                    var sep = str.componentsSeparatedByString("<")
                    var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
                    
                    var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
                    
                    if let json = allContacts as? Dictionary<String, Array<Int>> {
                        
                        returnvalue = json["returnvalue"]!
                        
                        for i : Int in returnvalue{
                            println(i)
                        }
                    }
                    responseMain(returnvalue, error: nil)
                }
                },failure: {(error: NSError, response: HTTPResponse?) in
            })
        //})
    
    }
    
    class func uploadImage(customerID: Int, image: String){
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": customerID, "image": image]
        request.POST(Config().UPLOADIMAGE, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
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
                        let decodedData = NSData(base64EncodedString: profileImage, options: NSDataBase64DecodingOptions(0))
                        var decodedimage = UIImage(data: decodedData!)
                        //println(decodedimage)
                        //decodedimage as UIImage
                        
                        DataHandler.saveUser(userID.toInt()!, firstname: userFirstName, lastname: userLastName, email: userEmail, image: decodedimage!)
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
    
    func login2(email: String, password: String, respone: ((HTTPResponse) -> Void)!) -> User{
        var request = HTTPTask()
        var returnvalue = User()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["tag": "login", "email": email, "password": password]
        request.POST(Config().LOGINURL, parameters: params, success: respone ,failure: {(error: NSError, response: HTTPResponse?) in
        })
        return returnvalue
        
    }
    
    class func uploadImage2(customerID: Int, image: String, respone: ((HTTPResponse) -> Void)!){
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": customerID, "image": image]
        request.POST(Config().UPLOADIMAGE, parameters: params, success: respone,failure: {(error: NSError, response: HTTPResponse?) in
            
        })
    }
    
}
