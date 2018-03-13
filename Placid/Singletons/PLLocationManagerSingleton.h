//
//  PLLocationManagerSingleton.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/03/12.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PLLocationManagerSingleton : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;

+ (PLLocationManagerSingleton*)sharedSingleton;

@end
