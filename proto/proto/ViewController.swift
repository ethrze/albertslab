//
//  ViewController.swift
//  proto
//
//  Created by Grace Phillips on 8/11/15.
//  Copyright (c) 2015 ccf. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var myBeaconRegion: CLBeaconRegion!
    var locationManager: CLLocationManager!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var proxLabel: UILabel!

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // init locMan and set self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        let uuid = NSUUID(UUIDString:"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
        let myBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 0, minor: 0, identifier: "MyBeacon")
        
        locationManager.startMonitoringForRegion(myBeaconRegion)
        locationManager.startRangingBeaconsInRegion(myBeaconRegion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didEnterRegion(manager:CLLocationManager, region:CLRegion) {
        locationManager.startRangingBeaconsInRegion(myBeaconRegion)
    }
    func didExitRegion(manager:CLLocationManager, region:CLRegion) {
        locationManager.stopRangingBeaconsInRegion(myBeaconRegion)
        statusLabel.text = "No beacon..."

    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons[0] //as! CLBeacon
            statusLabel.text = "Beacon Found!!"
            proxLabel.text = String(beacon.proximity)
        }
        else {
            statusLabel.text = "No beacon..."
            proxLabel.text = "..."
            
        }
    }
    
    /*
    func didRangeBeacons(manager:CLLocationManager, beacons:NSArray, region:CLBeaconRegion) {
        statusLabel.text = "Beacond found!!"
//        let foundBeacon = CLBeacon(beacons.firstObject)
    } */
    
    //var beacons = NSArray(didRangeBeacons)
      //  var region = CLBeaconRegion(inRegion)
    
    
}



