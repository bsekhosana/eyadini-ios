//
//  PLFoldAnimationController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSlidingViewController.h"

@interface PLFoldAnimationController : NSObject <UIViewControllerAnimatedTransitioning,
  ECSlidingViewControllerDelegate>
@end
