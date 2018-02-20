//
//  AppDelegate.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "AppDelegate.h"
#import "PLAPICLient.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "PLHomeViewController.h"
#import "PLMainNavigationController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Firebase/Firebase.h>
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
  // Shows iOS global spinner in OS toolbar
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  
  [NSThread sleepForTimeInterval:2];
  
  // Push Notification settings
  
  /*if ([YUMCustomerSession instance].customerCopy != nil) {
    // iOS 10 support
    if ([YUMConstants OS_VERSION] >= 10) {
      [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
          [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
      }];
      
      // iOS 8 & 9 support
    }else if([YUMConstants OS_VERSION] >= 8){
      
      UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
      [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
      [[UIApplication sharedApplication] registerForRemoteNotifications];
      
      // iOS 7 support
    }else if([YUMConstants OS_VERSION] >= 7){
      
      [[UIApplication sharedApplication] registerForRemoteNotifications];
      
    }
  }*/
  
  // Facebook
  [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
  // Add any custom logic here.
  
  
  [GIDSignIn sharedInstance].clientID = @"29198463966-rmjm04s897sakaptuhatnctbclo02b9e.apps.googleusercontent.com";
  [GIDSignIn sharedInstance].delegate = self;
  
  return [[FBSDKApplicationDelegate sharedInstance] application:application
                                  didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  
  [[GIDSignIn sharedInstance] handleURL:url
                      sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                             annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
  
  BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                openURL:url
                                                      sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                             annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                  ];
  // Add any custom logic here.
  return handled;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  
  [[GIDSignIn sharedInstance] handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
  
  BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                openURL:url
                                                      sourceApplication:sourceApplication
                                                             annotation:annotation
                  ];
  // Add any custom logic here.
  return handled;
} 
  
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  [FBSDKAppEvents activateApp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
  // Perform any operations on signed in user here.
  NSString *userId = user.userID;                  // For client-side use only!
  NSString *idToken = user.authentication.idToken; // Safe to send to the server
  NSString *fullName = user.profile.name;
  NSString *givenName = user.profile.givenName;
  NSString *familyName = user.profile.familyName;
  NSString *email = user.profile.email;
  // ...
  [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:@"loggedIn"];
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
  // Perform any operations when the user disconnects from app here.
  // ...
}


@end
