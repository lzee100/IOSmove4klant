//
//  Category.swift
//  Move4Klant
//
//  Created by Sander Wubs on 26/11/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//
import UIKit

class Category: NSObject {
    
    var ID: Int?
    var name: String?
    var liked: Int?
    
    override init(){}
    
    
    init(ID: Int, name: String)
    {
        self.ID = ID
        self.name=name
    }
    
    
    init(ID: Int, Name: String, liked: Int){
        self.ID = ID
        self.name = Name
        self.liked=liked
    }
    
    
    
    func setInfo(Id: Int, Name: String, liked: Int){
        self.ID = Id
        self.name = Name
        self.liked=liked
    }
    
    
}
