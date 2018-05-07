//
//  PLBaseViewController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
@import GoogleMobileAds;

@interface PLBaseViewController : UIViewController <ECSlidingViewControllerDelegate>

- (IBAction)menuButtonTapped:(id)sender;
-(void)setIsHomeScreen;
@end
