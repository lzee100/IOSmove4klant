//
//  ScanningBeacons.swift
//  iBeacons
//
//  Created by Leo van der Zee on 03-10-14.
//  Copyright (c) 2014 Move4Mobile. All rights reserved.
//

import UIKit
import CoreLocation

class ScanForBeacons: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var label_RangingBeacons: UILabel!
    
    
    var beacons: [CLBeacon]?
    var locationManager: CLLocationManager?
    var lastProximity: CLProximity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiateBeaconSetup()
    }
    
    func initiateBeaconSetup(){
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // beacon functions
    
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
            println(String(beacons.count))
            self.tableView.reloadData()
            
            var message:String = ""
            
            var playSound = false
            
            if(beacons.count > 0) {
                let nearestBeacon:CLBeacon = beacons[0] as CLBeacon
                
                if(nearestBeacon.proximity == lastProximity ||
                    nearestBeacon.proximity == CLProximity.Unknown) {
                        return;
                }
                lastProximity = nearestBeacon.proximity;
                
                switch nearestBeacon.proximity {
                case CLProximity.Far:
                    message = "You are far away from the beacon"
                    playSound = true
                case CLProximity.Near:
                    message = "You are near the beacon"
                case CLProximity.Immediate:
                    message = "You are in the immediate proximity of the beacon"
                case CLProximity.Unknown:
                    return
                }
            } else {
                
                if(lastProximity == CLProximity.Unknown) {
                    return;
                }
                
                message = "No beacons are nearby"
                playSound = true
                lastProximity = CLProximity.Unknown
            }
            
            NSLog("%@", message)
            sendLocalNotificationWithMessage(message, playSound: playSound)
    }
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!) {
            manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
            manager.startUpdatingLocation()
            
            NSLog("You entered the region")
            sendLocalNotificationWithMessage("You entered the region", playSound: false)
    }
    
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
            manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
            manager.stopUpdatingLocation()
            
            NSLog("You exited the region")
            sendLocalNotificationWithMessage("You exited the region", playSound: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // table functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (beacons != nil)
        {
            return beacons!.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let id = "scanForBeaconsCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath) as ScanForBeaconsCell
        
        let beacon:CLBeacon = beacons![indexPath.row]
        var proximityLabel:String! = ""
        
        switch beacon.proximity {
        case CLProximity.Far:
            proximityLabel = "Far"
        case CLProximity.Near:
            proximityLabel = "Near"
        case CLProximity.Immediate:
            proximityLabel = "Immediate"
        case CLProximity.Unknown:
            proximityLabel = "Unknown"
        }
        
        cell.label_OutPut_Proximity!.text = proximityLabel
        cell.label_OutPut_Major!.text = String(beacon.major.integerValue)
        cell.label_OutPut_Minor!.text = String(beacon.minor.integerValue)
        cell.label_OutPut_RSSI!.text = String(beacon.rssi as Int)
        
        let stringMajor = String(beacon.major.integerValue)
        let stringMinor = String(beacon.minor.integerValue)
        let stringProximity = proximityLabel
        let stringRSSI = String(beacon.rssi as Int)
        
        return cell
    }
    
    
}
