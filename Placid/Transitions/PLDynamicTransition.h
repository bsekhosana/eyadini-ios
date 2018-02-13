//
//  PLDynamicTransition.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSlidingViewController.h"
#import "ECPercentDrivenInteractiveTransition.h"

@interface PLDynamicTransition : NSObject <UIViewControllerInteractiveTransitioning,
                                          UIDynamicAnimatorDelegate,
                                          ECSlidingViewControllerDelegate>
  @property (nonatomic, assign) ECSlidingViewController *slidingViewController;
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer;

@end
