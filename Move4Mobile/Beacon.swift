//
//  Beacon.swift
//  Move4Klant
//
//  Created by Sander Wubs on 28/11/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class Beacon: NSObject {
    var ID: Int?
    var productID : Int?
    var offerID: Int?
    var major: Int?
    var minor: Int?
    
    override init(){}
    
    
    init(ID: Int, productID : Int , offerID: Int, major: Int?, minor:Int )
    {
        self.ID = ID
        self.productID=productID
        self.offerID=offerID
        self.major=major
        self.minor=minor
    }
    
    func toString() -> String{
        return "ID: \(ID)  productID: \(productID)  offerID: \(offerID) major: \(major)  minor:  \(minor)"
    }
    
    
    

}
