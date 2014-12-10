//
//  AppDelegate.swift
//  Move4Mobile
//
//  Created by Leo van der Zee on 25-11-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var beacons: [CLBeacon]?
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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window?.makeKeyAndVisible()
        
        if ((self.window?.rootViewController as? UINavigationController) != nil) {
            nav = self.window!.rootViewController as UINavigationController!
            println("navigationcontroller succeeded")
        }
        
        let uuid : NSUUID = NSUUID(UUIDString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!
        let beaconIdentifier = "iBeaconModules.us"
        let beaconUUID: NSUUID = uuid
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        
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
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
            self.beacons = beacons as [CLBeacon]?

            var message:String = ""
            var playSound = false
            
// -------- if beacon is found ------------------
            if(beacons.count > 0) {
                // get de nearest beacon
                let nearestBeacon:CLBeacon = beacons[0] as CLBeacon
                // set time when beacon is found
                endTime = NSDate()
                
                // beacon information
                lastProximity = nearestBeacon.proximity;
                let major = nearestBeacon.major.integerValue
                var rssi = nearestBeacon.rssi
                println("\(rssi)")
                
                // check distance
                
// ------------ distance = immidiate ----------------
                if (rssi > -60 && rssi != 0){
                    if activateNewScreen() {
                        productActive = true
                        showProduct()
                    }
                
// ------------ distance = near ----------------------
                } else if (rssi < -60 && rssi > -90) {
                    // get offer
                    let offer = Offer(ID: 0, categoryID: 0, offerdescription: "0")
                    // if product screen is not active
                    if !productActive {
                        // if offer is not yet shown to customer
                        if !isOfferShown(offer) {
                            showNotification("Speciale offer", swipeMessage: "zien wat de actie is!")
                            showOffer()
                        }
                    }
                }
            }
    }
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!) {
            manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
            manager.startUpdatingLocation()
            
            NSLog("You entered the region")
            //sendLocalNotificationWithMessage("You entered the region", playSound: false)
    }
    
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
            manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
            manager.stopUpdatingLocation()
            
            NSLog("You exited the region")
            //sendLocalNotificationWithMessage("You exited the region", playSound: true)
    }
    
    func showProduct() {
        let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let vc  = storyboard.instantiateViewControllerWithIdentifier("Product") as ProductView
        
        nav?.presentViewController(vc, animated: true, completion: nil)
    }
    
    func showOffer() {
        let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let vc  = storyboard.instantiateViewControllerWithIdentifier("Offer") as OfferView
        
        nav?.presentViewController(vc, animated: true, completion: nil)

        
    }
    
    func activateNewScreen() -> Bool {
        if startTime == nil {
            startTime = NSDate()
            return true
        }else if startTime != nil {
            let timeInterval: Double = self.endTime!.timeIntervalSinceDate(startTime!)
            if (timeInterval > 3){
                startTime = NSDate()
                return true
            }
        }
        return false
    }
    
    func isOfferShown(offer : Offer) -> Bool {
        if offersShown == nil {
            offersShown = [Offer]()
            offersShown!.append(offer)
            return false
        } else {
            for offerCheck in offersShown! {
                if offerCheck.ID == offer.ID {
                    return true
                }
            }
            offersShown!.append(offer)
        }
        
        return false
    } // if offer allready shown?
    
    func showNotification(message : String, swipeMessage : String) {
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = swipeMessage
        localNotification.alertBody = message
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

}

