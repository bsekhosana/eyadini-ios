//
//  PLBaseViewController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface PLBaseViewController : UIViewController <ECSlidingViewControllerDelegate>
- (IBAction)menuButtonTapped:(id)sender;
@end
