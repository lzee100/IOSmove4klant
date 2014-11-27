//
//  ServerRequestHandler.swift
//  Move4Klant
//
//  Created by Sander Wubs on 26/11/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

public class ServerRequestHandler: NSObject {
    
 public func getAllCategories() {
   //var request = NSMutableURLRequest(URL:Config().CATEGORYURL)
    
    var request = HTTPTask()
    request.GET(Config().CATEGORYURL, parameters: nil, success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("response: \(str)") //prints the HTML of the page
        }
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("error: \(error)")
    })
}
    
    public func getAllOffers(){
        var request = HTTPTask()
        request.GET(Config().GETALLOFFERS, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })
    }
    
    
    public func getAllBeacons(){
        var request = HTTPTask()
        request.GET(Config().GETALLBEACONS, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })
    }
    
    
    public func getAllProducts(){
        var request = HTTPTask()
        request.GET(Config().GETALLPRODUCTS, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })
    }
    
    
    
    public func checkinout(userID: Int){
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["customerID": userID]
        request.POST(Config().LOGINURL, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                
        })
    }


   
    
//    public func getAllOffers(){
//        var request = HTTPTask()
//        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
//        let params: Dictionary<String,AnyObject> = ["param": "param1", "array": ["first array element","second","third"], "num": 23, "dict": ["someKey": "someVal"]]
//        request.POST("http://domain.com/create", parameters: params, success: {(response: HTTPResponse) in
//            
//            },failure: {(error: NSError, response: HTTPResponse?) in
//                
//        })
//    }
}
