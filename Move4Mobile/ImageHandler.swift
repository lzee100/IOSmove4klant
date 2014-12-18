//
//  ImageHandler.swift
//  Move4Klant
//
//  Created by Sander Wubs on 17/12/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import Foundation
import UIKit
import CoreData


public class ImageHandler{
    
    
    class func base64ToUIImage(base64String: String) -> UIImage {
        
        if let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(0)){
            var decodedimage : UIImage = UIImage(data: decodedData)!
            return decodedimage
        }
        else { return UIImage() }
    }
    
    
    class func UIImageToBase64(image: UIImage) -> String{
        var imagedata = UIImagePNGRepresentation(image)
        let base64String = imagedata.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
        return base64String
    }
    
    
    class func resizeImage(image :UIImage) -> UIImage {
        var newSize:CGSize = CGSize(width: 200,height: 200)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        // image is a variable of type UIImage
        image.drawInRect(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    
}


