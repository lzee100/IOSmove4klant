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
    request.GET(Config, parameters: nil, success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("response: \(str)") //prints the HTML of the page
        }
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("error: \(error)")
    })
}
   
}
