//
//  Offer.swift
//  Move4Klant
//
//  Created by Sander Wubs on 27/11/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class Offer: NSObject {
    
    var ID: Int?
    var categoryID : Int?
    var offerdescription: String?
    var image: UIImage?
    var serverImagePath : String?
    
    override init(){}
    
    
    init(ID: Int, categoryID : Int , offerdescription: String, image: UIImage)
    {
        self.ID = ID
        self.categoryID=categoryID
        self.offerdescription=offerdescription
        self.image=image
    }
    
    
    init(ID: Int, categoryID : Int , offerdescription: String){
        self.ID = ID
        self.categoryID=categoryID
        self.offerdescription=offerdescription
    }
    
    func toString() -> String{
        return "ID: \(ID)  categoryID: \(categoryID)  Description: \(offerdescription) "
    }
    
    func setImage(image: UIImage){
        self.image=image
    }
    
    
    func setImagePath(imagePath: String){
        self.serverImagePath=imagePath
    }
    
    
    

}
