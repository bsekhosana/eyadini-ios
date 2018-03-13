//
//  PLLocationManagerSingleton.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/03/12.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLLocationManagerSingleton.h"

@implementation PLLocationManagerSingleton
@synthesize locationManager;
const static double lat = -29.957270, lon = 30.923107;

- (id)init {
  self = [super init];
  
  if(self) {
    self.locationManager = [CLLocationManager new];
    [self.locationManager setDelegate:self];
    [self.locationManager setDistanceFilter:kCLLocationAccuracyBest];
    [self.locationManager setHeadingFilter:kCLHeadingFilterNone];
    [self.locationManager startUpdatingLocation];
    //do any more customization to your location manager
  }
  
  return self;
}

+ (PLLocationManagerSingleton*)sharedSingleton {
  static PLLocationManagerSingleton* sharedSingleton;
  if(!sharedSingleton) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedSingleton = [PLLocationManagerSingleton new];
    });
  }
  
  return sharedSingleton;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
  //handle your location updates here
  NSLog(@"Location did update to :  lat - %f .... lon - %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
  //handle your heading updates here- I would suggest only handling the nth update, because they
  //come in fast and furious and it takes a lot of processing power to handle all of them
}

@end
