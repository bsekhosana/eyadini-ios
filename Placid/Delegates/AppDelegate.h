//
//  AppDelegate.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLConstants.h"
#import <AFNetworking/AFNetworking.h>
#import <ECSlidingViewController/ECSlidingViewController.h>
@import GoogleMobileAds;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

