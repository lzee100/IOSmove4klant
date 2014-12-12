//
//  DataHandler.swift
//  Move4Klant
//
//  Created by Sander Wubs on 09/12/14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import Foundation
import UIKit
import CoreData


public class DataHandler{
    
    
    //Products
    
    class func updateProducts(){
        
        //step 1 get context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //step 2 get products from server
        var products: [Product] = ServerRequestHandler().getAllProducts()
        
        //step 3 check if data from server is not empty
        if products.count > 0{
            
            //step 4 delete current stored data
            var dbdata = getManagedObjects("Product")
            
            for m :NSManagedObject in dbdata{
                managedContext.deleteObject(m)
            }
            
            //step 5 store data from server
            for p: Product in products{
                let entity = NSEntityDescription.entityForName("Product", inManagedObjectContext: managedContext)
                var product = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                product.setValue(p.categoryID, forKey: "categoryID")
                product.setValue(p.ID, forKey: "id")
                product.setValue(p.name, forKey: "name")
                product.setValue(p.productdescription, forKey: "productdescription")
            }
        }
    }
    
    class func getProductsFromDB() ->  [Product]{
            var dbdata = [NSManagedObject]()
        
        var products = [Product]()
        //stap 1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "Product")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            dbdata=results
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        for p: NSManagedObject in dbdata{
            var id: Int = p.valueForKey("id") as Int
            var catid: Int = p.valueForKey("categoryID") as Int
            var name: String = p.valueForKey("name") as String
            var desc: String = p.valueForKey("productdescription") as String
            
           var pr : Product = Product(ID: id, categoryID: catid, productdescription: name, name: desc)
            products.append(pr)
        }
        return products
    }
    
    class func getProductByID(productID: Int) -> Product{
        var dbdata = [NSManagedObject]()
        
        var products : Product = Product()
        //stap 1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "Product")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            dbdata=results
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        for p: NSManagedObject in dbdata{
            var id: Int = p.valueForKey("id") as Int
            
            if (id == productID){
            var catid: Int = p.valueForKey("categoryID") as Int
            var name: String = p.valueForKey("name") as String
            var desc: String = p.valueForKey("productdescription") as String
            
            products = Product(ID: id, categoryID: catid, productdescription: name, name: desc)
            }
        }
        return products
  
    }
    
    
    
    //Categories
    
    class func updateCategories(){
        
        //step 1 get context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //step 2 get categories from server
        var categories: [Category] = ServerRequestHandler().getAllCategories()
        
        //step 3 check if data from server is not empty
        if categories.count > 0{
            
            //step 4 delete current stored data
            var dbdata = getManagedObjects("Categories")
            
            for m :NSManagedObject in dbdata{
                managedContext.deleteObject(m)
            }

            //step 5 store data from server
            for p: Category in categories{
                let entity = NSEntityDescription.entityForName("Categories", inManagedObjectContext: managedContext)
                var cat = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
                cat.setValue(p.ID, forKey: "id")
                cat.setValue(p.name, forKey: "name")
                cat.setValue(0, forKey: "liked")
            }
        }
    }
    
    class func getCategoriesFromDB() ->  [Category]{
        var dbdata = [NSManagedObject]()
        
        var categories = [Category]()
        //stap 1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "Categories")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            dbdata=results
            for p: NSManagedObject in dbdata{
                var id: Int = p.valueForKey("id") as Int
                var name: String = p.valueForKey("name") as String
                var liked: Int = p.valueForKey("liked") as Int
                
                var cat : Category = Category(ID: id, Name: name, liked: liked)
                categories.append(cat)
            }
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        return categories
    }
    
    class func getLikedCategoriesFromDB() -> [Category]{
        var dbdata = [NSManagedObject]()
        
        var categories = [Category]()
        //stap 1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "Categories")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            dbdata=results
            for p: NSManagedObject in dbdata{
                
                if p.valueForKey("liked")as Int == 1{
                    var id: Int = p.valueForKey("id") as Int
                    var name: String = p.valueForKey("name") as String
                    var liked: Int = p.valueForKey("liked") as Int
                
                    var cat : Category = Category(ID: id, Name: name, liked: liked)
                    categories.append(cat)
                }
            }
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        return categories
    }
    
    class func storeLikesFromServerLocally(userID: Int) -> [Int]{
        var returnvalue: [Int] = [Int]()
        
        ServerRequestHandler.getLikes(userID, respone: {(response: HTTPResponse) -> Void in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var sep = str.componentsSeparatedByString("<")
                var henk = sep[0].dataUsingEncoding(NSUTF8StringEncoding)
                
                var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(henk!, options: NSJSONReadingOptions(0), error: nil)
                
                if let json = allContacts as? Dictionary<String, Array<Int>> {
                    
                    returnvalue = json["returnvalue"]!
                    
                    var cats:[NSManagedObject] = self.getManagedObjects("Categories")
                    
                    
                    for i : Int in returnvalue{
                        for category : NSManagedObject in cats{
                            if category.valueForKey("id") as Int==i{
                                category.setValue(1, forKey: "liked")
                            }
                        }
                    }
                }
            }
            
        })
        return returnvalue
    }
    
    class func saveLikes(categories :[Category]) {
        var dbdata = [NSManagedObject]()
        
        //stap 1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "Categories")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            dbdata=results
            for p: NSManagedObject in dbdata{
                var id: Int = p.valueForKey("id") as Int
                var name: String = p.valueForKey("name") as String
                var liked: Int = p.valueForKey("liked") as Int
                
                for cat : Category in categories{
                    if cat.ID==id{
                        p.setValue(cat.liked, forKey: "liked")
                    }
                }
            }
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
    }

    
    
    
    //Beacons
    
    class func updateBeacons(){
 
        //step 1 get context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        
        //step 2 get beacon from server
        var beacons: [Beacon] = ServerRequestHandler().getAllBeacons()
        
        //step 3 check if data from server is not empty
        if beacons.count > 0{
            
            //step 4 delete current stored data
            var dbdata = getManagedObjects("Beacon")
            
            for m :NSManagedObject in dbdata{
                managedContext.deleteObject(m)
                //m.delete(self)
            }
            
            //step 5 store data from server
            for b: Beacon in beacons{
                let entity = NSEntityDescription.entityForName("Beacon", inManagedObjectContext: managedContext)
                var beacon = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                beacon.setValue(b.ID, forKey: "id")
                beacon.setValue(b.offerID, forKey: "offerID")
                beacon.setValue(b.productID, forKey: "productID")
                beacon.setValue(b.major, forKey: "major")
                beacon.setValue(b.minor, forKey: "minor")
            }
        }
    }
    
    class func getBeaconsFromDB() ->  [Beacon]{
        var dbdata = [NSManagedObject]()
        
        var beacons = [Beacon]()
        //stap 1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "Beacon")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            dbdata=results
            for b: NSManagedObject in dbdata{
    
                let id = b.valueForKey("id") as Int
                let offerid = b.valueForKey("offerID") as Int
                let productid = b.valueForKey("productID") as Int
                let major = b.valueForKey("major") as Int
                let minor = b.valueForKey("minor") as Int
                
                var beacon : Beacon = Beacon(ID: id, productID: productid, offerID: offerid, major: major, minor: minor)
                beacons.append(beacon)
            }
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        return beacons
    }
    
    
    
    //Offers
    
    class func updateOffers(){
        
        //step 1 get context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //step 2 get offers from server
        var offers: [Offer] = ServerRequestHandler().getAllOffers()
        
        //step 3 check if data from server is not empty
        if offers.count > 0{
            
            //step 4 delete current stored data
            var dbdata = getManagedObjects("Offer")
            
            for m :NSManagedObject in dbdata{
                managedContext.deleteObject(m)
            }
            
            //step 5 store data from server
            for o: Offer in offers{
                let entity = NSEntityDescription.entityForName("Offer", inManagedObjectContext: managedContext)
                var offer = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
                offer.setValue(o.ID, forKey: "id")
                offer.setValue(o.offerdescription, forKey: "offerDescription")
                offer.setValue(o.categoryID, forKey: "categoryID")
            }
        }
    }
    
    class func getOffersFromDB() ->  [Offer]{
        var dbdata = [NSManagedObject]()
        
        var offers = [Offer]()
        //stap 1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "Offer")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            dbdata=results
            for o: NSManagedObject in dbdata{
                
                let id = o.valueForKey("id") as Int
                let desc = o.valueForKey("offerDescription") as String
                let catid = o.valueForKey("categoryID") as Int
                
                var offer : Offer = Offer(ID: id, categoryID: catid, offerdescription: desc)
                offers.append(offer)
            }
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        return offers
    }
    
    class func getOfferByID(offerID: Int) -> Offer{
        var dbdata = [NSManagedObject]()
        
        var offer = Offer()
        //stap 1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "Offer")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            dbdata=results
            for o: NSManagedObject in dbdata{
                
                let id = o.valueForKey("id") as Int
                if id==offerID{
                    let desc = o.valueForKey("offerDescription") as String
                    let catid = o.valueForKey("categoryID") as Int
                    
                    offer = Offer(ID: id, categoryID: catid, offerdescription: desc)
                }
                
              
            }
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        return offer
    }
    
    
    
    //User
    
    class func saveUser(id : Int, firstname:String, lastname: String, email:String){
        
        //step 1 get context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //step 2 delete current stored data
        var dbdata = getManagedObjects("User")
        
        for m :NSManagedObject in dbdata{
            managedContext.deleteObject(m)
        }

        //step 3 store user
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        var user = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        user.setValue(id, forKey: "id")
        user.setValue(firstname, forKey: "firstname")
        user.setValue(lastname, forKey: "lastname")
        user.setValue(email, forKey: "email")
    }
    
    class func getUserID()-> Int{
        var id :Int = Int()
        
        //step 1 get context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //step 2 get user from coredata
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        //step 3 fetch result
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        if let results = fetchedResults {
            for o: NSManagedObject in results{
                id = o.valueForKey("id") as Int
            }
        }
        return id
    }
    
    class func getUserFromDB() -> User {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        var user: User = User()
        
        //stap 2
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        //stap 3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            
            for o: NSManagedObject in results{
                
                let id = o.valueForKey("id") as Int
                let firstname = o.valueForKey("firstname") as String
                let lastname = o.valueForKey("lastname") as String
                let email = o.valueForKey("email") as String
                user = User(uID: id, uName: firstname, uLastName: lastname, uEmail: email)
            }
        }
        return user
    }
    
    
    
    //Other
    
    class func updateAll(){
        updateBeacons()
        updateCategories()
        updateProducts()
        updateOffers()
    }
    
    class func getManagedObjects(entity: String) -> [NSManagedObject]{
        //returnvalue
        var dbdata = [NSManagedObject]()
        
        //get context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //get results from specified entity from coredata
        let fetchRequest = NSFetchRequest(entityName: entity)
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        if let results = fetchedResults {
            dbdata=results
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        return dbdata
    }
    
}
