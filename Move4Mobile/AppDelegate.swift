
//
//  AppDelegate.swift
//  Move4Mobile
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var logIn = false
    var user : User?
    var likes : [Category]?
    let uuid : NSUUID = NSUUID(UUIDString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!
    var beaconsFromDataBase : [Beacon]?
    var rangedBeacon : Beacon?
    var offer : Offer?
    var beacons = [CLBeacon]()
    var locationManager: CLLocationManager?
    var lastProximity: CLProximity?
    let beaconID = 31690
    let adverticementHasBeenShown = 0
    var startTime : NSDate?
    var endTime : NSDate?
    var elapsedTime = 0
    var nav : UINavigationController?
    var offersShown : [Offer]?
    var productActive = false
    var startTimer = true
    var customerInStore = false
    var timer : NSTimer?
    var timerActive = false
    var checkingLogIn = false
    var rssi : Int?
    var product : Product?
    var didEnterBackground = false
    var notificationProductShown = false
    var timerProductNotification : NSTimer?
    
    
    lazy var applicationDocumentsDirectory: NSURL = {
        
        // The directory the application uses to store the Core Data store file. This code uses a directory named "y.Simple_Grade" in the application's documents Application Support directory.
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        return urls[urls.count-1] as NSURL
        
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        
        let modelURL = NSBundle.mainBundle().URLForResource("Move4Klant", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        
        // Create the coordinator and store
        
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Simple_Grade.sqlite")
        
        var error: NSError? = nil
        
        var failureReason = "There was an error creating or loading the application's saved data."
        
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            
            coordinator = nil
            
            // Report any error we got.
            
            let dict = NSMutableDictionary()
            
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error
            
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            // Replace this with code to handle the error appropriately.
            
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            
            abort()
            
        }
        
        
        
        return coordinator
        
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        
        let coordinator = self.persistentStoreCoordinator
        
        if coordinator == nil {
            
            return nil
            
        }
        
        var managedObjectContext = NSManagedObjectContext()
        
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
        
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        
        if let moc = self.managedObjectContext {
            
            var error: NSError? = nil
            
            if moc.hasChanges && !moc.save(&error) {
                
                // Replace this implementation with code to handle the error appropriately.
                
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                
                abort()
                
            }
            
        }
        
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window?.makeKeyAndVisible()
        
        if ((self.window?.rootViewController as? UINavigationController) != nil) {
            nav = self.window!.rootViewController as UINavigationController!
        }
        
        let beaconIdentifier = "iBeaconModules.us"
        let beaconUUID: NSUUID = uuid
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        
        beaconRegion.notifyEntryStateOnDisplay = true
        
        locationManager = CLLocationManager()
        
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager!.requestAlwaysAuthorization()
        }
        
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
        
        // iBeacon range notification
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                    categories: nil
                )
            )
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        didEnterBackground = true
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        didEnterBackground = false
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    func sendLocalNotificationWithMessage(message: String!, playSound: Bool) {
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        
        if(playSound) {
            // classic star trek communicator beep
            //	http://www.trekcore.com/audio/
            //
            // note: convert mp3 and wav formats into caf using:
            //	"afconvert -f caff -d LEI16@44100 -c 1 in.wav out.caf"
            // http://stackoverflow.com/a/10388263
            
            notification.soundName = "tos_beep.caf";
        }
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!,
        didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
            self.beacons = beacons as [CLBeacon]
            
            for var i = 0; i < self.beacons.count; i++ {
                var beacon : CLBeacon = beacons[i] as CLBeacon
                if beacon.rssi == 0 {
                    self.beacons.removeAtIndex(i)
                }
            }
            
            var message:String = ""
            var playSound = false
            // check if user is logged in
            if logIn {
                // ------------ if beacon is found ------------------
                if(self.beacons.count > 0) {
                    
                    // get info db
                    user = DataHandler.getUserFromDB()
                    beaconsFromDataBase = DataHandler.getBeaconsFromDB()
                    likes = DataHandler.getLikedCategoriesFromDB()
                    
                    // check if checker is not checking
                    if (!checkingLogIn) {
                        // check if customer is in store
                        checkUserInStore()
                    }
                    
                    
                    if beaconsFromDataBase!.count != 0 {
                        
                        // get de nearest beacon
                        let nearestBeacon:CLBeacon = self.beacons[0] as CLBeacon
                        
                        // beacon information
                        lastProximity = nearestBeacon.proximity;
                        let major = nearestBeacon.major.integerValue
                        rssi = nearestBeacon.rssi
                        println(rssi)
                        // get rangedBeacon and assign it to a beacon object
                        for beacon in beaconsFromDataBase! {
                            if nearestBeacon.minor == beacon.minor {
                                rangedBeacon = beacon
                                break
                            }
                        }
                        if (nearestBeacon.major != nil){
                            // ------------ distance == immidiate ----------------
                            if (rssi > -70 && rssi != 0){
                                // get product from beacon
                                product = DataHandler.getProductByID(rangedBeacon!.productID!)
                                
                                // if in background
                                if didEnterBackground {
                                    // beacon moet ontvangen zijn
                                    if rssi != nil {
                                        if rssi > -60 && rssi != 0 {
                                            if product != nil {
                                                if !notificationProductShown {
                                                    showNotificationProduct(product!)
                                                    println("background notification")
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                                
                                // only once per 3 seconds
                                if activateNewScreen() {
                                    showProduct(product!)
                                }
                                
                                // ------------ distance == near ----------------------
                            } else if (rssi < -70 && rssi > -90) {
                                
                                // get offer from ranged beacon
                                if rangedBeacon != nil{
                                    offer = DataHandler.getOfferByID(rangedBeacon!.offerID!)
                                    //println("ranged beacon offer ID: \(rangedBeacon?.offerID)")
                                    
                                    
                                    // see if offer is liked by user
                                    //println("offerID : \(offer!.ID)")
                                    var userWantsOffer = false
                                    for like : Category in likes! {
                                        //println("LikedID : \(like.ID)")
                                        if like.ID == offer!.categoryID {
                                            userWantsOffer = true
                                            //println("userWantsOffer")
                                        }
                                    }
                                    // if offer is liked by user
                                    if userWantsOffer {
                                        // if product screen is not active
                                        if !productActive {
                                            // if offer is not yet shown to customer (customer recieves only once an offer)
                                            if !isOfferShown(offer!) {
                                                showOffer(offer!)
                                                if didEnterBackground {
                                                    dispatch_sync(dispatch_get_main_queue()){
                                                        self.showNotificationOffer(self.offer!)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } // end if no beacons yet in db.
                } // no beacons found when counting them
            } // end check if user is loggedIn
            
    }
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!) {
            manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
            manager.startUpdatingLocation()
            showNotification("Je bent bij onze winkel. Open de app.", swipeMessage: "activeren")
            NSLog("You entered the region")
            //sendLocalNotificationWithMessage("You entered the region", playSound: false)
    }
    
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
            //manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
            //manager.stopUpdatingLocation()
            // if customer is instore, set outStore date to compare with instore date
            if customerInStore {
                if !timerActive {
                    timer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: Selector("checkOut"), userInfo: nil, repeats: true)
                    println("timer started")
                    timerActive = true
                }
            }
            
            NSLog("You exited the region")
            //sendLocalNotificationWithMessage("You exited the region", playSound: true)
    }
    
    func showProduct(product : Product) {
        let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        var vc  = storyboard.instantiateViewControllerWithIdentifier("Product") as ProductView
        vc.labelTitleForSetting = product.name!
        vc.labelDescriptionForSetting = product.productdescription!
        //ToDo Sander:
        // let image = product.image (toImage in product).... (from string64 to image)
        //vc.imageView_productImage.image = image
        
        if product.image != nil{
            vc.productImage = product.image
        }
       

        
        
        nav?.presentViewController(vc, animated: true, completion: nil)
    }
    
    func showOffer(offer : Offer) {
        let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let vc  = storyboard.instantiateViewControllerWithIdentifier("Offer") as OfferView
        vc.labelDescriptionValue = offer.offerdescription
        
        if offer.image != nil{
            vc.offerImage = offer.image
        }
        
        nav?.presentViewController(vc, animated: true, completion: nil)
    }
    
    func activateNewScreen() -> Bool {
        if startTime == nil {
            startTime = NSDate()
            return true
        }else if startTime != nil {
            endTime = NSDate()
            let timeInterval: Double = self.endTime!.timeIntervalSinceDate(startTime!)
            if (timeInterval > 3){
                startTime = NSDate()
                return true
            }
        }
        return false
    } // screen will only appear every 3 seconds
    
    func isOfferShown(offer : Offer) -> Bool {
        
        if offersShown == nil {
            offersShown = [Offer]()
            offersShown!.append(offer)
            return false
        }
        
            
        for offerCheck : Offer in offersShown! {
            if offerCheck.ID == offer.ID {
                    return true
            }
        }

        offersShown!.append(offer)
        return false
    } // is offer allready shown?
    
    func showNotification(message : String, swipeMessage : String) {
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = swipeMessage
        localNotification.alertBody = message
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        localNotification.soundName = "tos_beep.caf"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    } // if screen is locked, show swipe message
    
    func showNotificationProduct(product : Product) {
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Actie: " + product.productdescription!
        localNotification.alertBody = "Actie: " + product.productdescription!
        localNotification.soundName = "tos_beep.caf"
        localNotification.fireDate = nil
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

        // product notification is shown
        notificationProductShown = true
        // set timer for 30 seconds to not show notification again
        timerProductNotification = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "resetNotificationProductShown", userInfo: nil, repeats: false)
    } // if screen is locked, show swipe message
    
    func showNotificationOffer(offer : Offer) {
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Actie: " + offer.offerdescription!
        localNotification.alertBody = "Actie: " + offer.offerdescription!
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        localNotification.soundName = "tos_beep.caf"
        localNotification.fireDate = nil
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    } // if screen is locked, show swipe message
    
    func resetNotificationProductShown() {
        notificationProductShown = false
        timerProductNotification?.invalidate()
    }
    
    func checkIn(){
        ServerRequestHandler.checkinout(user!.userID!)
        timerActive = false
    }
    
    func checkOut(){
        ServerRequestHandler.checkinout(user!.userID!)
        timerActive = false
        customerInStore = false
        timer?.invalidate()
        println("user is checked out")
    }
    
    func checkUserInStore() {
        checkingLogIn = true
        ServerRequestHandler.checkinStatus(user!.userID!, responseMain: { (success, error) -> () in
            self.customerInStore = success
            if (success) {
                println("In store")
                self.checkingLogIn = false
            } else {
                println("Out store")
                self.checkIn()
                self.checkingLogIn = false
            }
            self.checkingLogIn = false
        })
    }
    
}

