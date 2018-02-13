//
//  PLTransitions.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSlidingViewController.h"
#import "PLFoldAnimationController.h"
#import "PLZoomAnimationController.h"
#import "PLDynamicTransition.h"

FOUNDATION_EXPORT NSString *const PLTransitionNameDefault;
FOUNDATION_EXPORT NSString *const TransitionNameFold;
FOUNDATION_EXPORT NSString *const PLTransitionNameZoom;
FOUNDATION_EXPORT NSString *const PLTransitionNameDynamic;


@interface PLTransitions : NSObject{
  NSArray *_all;
}

  @property (nonatomic, strong) PLFoldAnimationController *foldAnimationController;
  @property (nonatomic, strong) PLZoomAnimationController *zoomAnimationController;
  @property (nonatomic, strong) PLDynamicTransition *dynamicTransition;
  @property (nonatomic, strong, readonly) NSArray *all;
  
@end
