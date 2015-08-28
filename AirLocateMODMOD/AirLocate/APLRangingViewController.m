

#import "APLRangingViewController.h"
#import "APLDefaults.h"
@import CoreLocation;

@interface APLRangingViewController () <CLLocationManagerDelegate>

@property NSMutableDictionary *beacons;
@property CLLocationManager *locationManager;
@property CLBeaconRegion *region;

@end


@implementation APLRangingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // This location manager will be used to demonstrate how to range beacons.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:[uuid UUIDString]];
    
    [self.locationManager startRangingBeaconsInRegion:region];
    
    self.region = region;
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    // Stop ranging when the view goes away.
    [self.locationManager stopRangingBeaconsInRegion:self.region];
}


#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    NSLog(@"Ranged beacons: %@", beacons);
}

@end
