//
//  Product.swift
//  Move4Klant
//
//  Created by Sander Wubs on 27/11/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit

class Product: NSObject {
    
    var ID: Int?
    var categoryID : Int?
    var name: String?
    var image: UIImage?
    var productdescription: String?
    var serverImagePath : String?
    
    override init(){}
    
    
    init(ID: Int, categoryID : Int , productdescription: String, image: UIImage, name:String )
    {
        self.ID = ID
        self.categoryID=categoryID
        self.productdescription=productdescription
        self.image=image
        self.name=name
    }
    
    
    init(ID: Int, categoryID : Int , productdescription: String, name:String ){
        self.ID = ID
        self.categoryID=categoryID
        self.productdescription=productdescription
        self.name=name
    }
    
    init(ID: Int, productdescription: String, name:String ){
        self.ID = ID
        self.productdescription=productdescription
        self.name=name
    }
    
    init(ID: Int, productdescription: String, name:String, image:UIImage){
        self.ID = ID
        self.productdescription=productdescription
        self.name=name
        self.image=image
    }

    
    func toString() -> String{
        return "ID: \(ID)  categoryiD: \(categoryID)  name: \(name)  description:  \(productdescription)"
    }
    
    func setImage(image: UIImage){
        self.image=image
    }
    
    func setImagePath(imagePath: String){
        self.serverImagePath=imagePath
    }
    
    
}
