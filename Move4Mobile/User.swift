//
//  User.swift
//  Move4Klant
//
//  Created by Leo van der Zee on 27-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var userID      : Int?
    var name        : String?
    var lastName    : String?
    var email       : String?
    
    var filePath    : NSString?
    var byteArray   : NSMutableData?
    
    override init(){
    }
    
    init(uName : NSString, uLastName : NSString, uEmail : NSString){}
    init(uID : Int, uName : NSString, uLastName : NSString, uEmail : NSString){
        self.userID     = uID
        self.name       = uName
        self.lastName   = uLastName
        self.email      = uEmail
    }
    
    func createUserWithName (uName : NSString, uLastName : NSString, uEmail : NSString) {
        self.name       = uName
        self.lastName   = uLastName
        self.email      = uEmail
    }
    
    func setUserID(id : Int) {
        self.userID = id
    }
    
    func setFilePath (stringFilePath : NSString) {
        self.filePath = stringFilePath
    }
    
    func setByteArrayImage (data : NSMutableData) {
        self.byteArray = data
    }
    
    func getUserID() -> Int{
        return userID!
    }
    
}
