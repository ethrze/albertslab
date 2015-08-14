import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var myBeaconRegion: CLBeaconRegion!
    var locationManager: CLLocationManager!
    // UI elements
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var proxLabel: UILabel!
    @IBOutlet weak var distanceReading: UILabel!

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // init locMan and set self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        view.backgroundColor = UIColor.grayColor()
        
    }
    
    func startScanning() {
        // create NSUUID w/ same ID as beacon
        let uuid = NSUUID(UUIDString:"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
        // setup new region w/ that UUID and the same beacon identifier
        let myBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 0, minor: 0, identifier: "com.example.apple-samplecode.AirLocate")
        // tell it to start monitoring for the beacon
        locationManager.startMonitoringForRegion(myBeaconRegion)
        locationManager.startRangingBeaconsInRegion(myBeaconRegion)
    }
    
    func didChangeAuthorizationStatus() {
        // do stuff
        startScanning()
        
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff

                }
            }
        }
    }
    /*
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region:CLRegion) {
        locationManager.startRangingBeaconsInRegion(myBeaconRegion)
    }
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        locationManager.stopRangingBeaconsInRegion(myBeaconRegion)
        statusLabel.text = "No beacon..."
    }

    */
    
    func updateDistance(distance: CLProximity) {
        UIView.animateWithDuration(0.8) { [unowned self] in
            switch distance {
            case .Unknown:
                self.view.backgroundColor = UIColor.grayColor()
                self.distanceReading.text = "UNKNOWN"
                self.proxLabel.text = "UNKNOWN"
                
            case .Far:
                self.view.backgroundColor = UIColor.blueColor()
                self.distanceReading.text = "FAR"
                
            case .Near:
                self.view.backgroundColor = UIColor.orangeColor()
                self.distanceReading.text = "NEAR"
                
            case .Immediate:
                self.view.backgroundColor = UIColor.redColor()
                self.distanceReading.text = "RIGHT HERE"
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons[0] //as! CLBeacon
            updateDistance(beacon.proximity)
            statusLabel.text = "Beacon Found!!"
            proxLabel.text = String(beacon.proximity)
        }
        else {
            updateDistance(.Unknown)
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



