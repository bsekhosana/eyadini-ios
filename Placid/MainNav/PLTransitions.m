//
//  PLTransitions.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLTransitions.h"

NSString * const PLTransitionNameDefault = @"Default";
NSString * const PLTransitionNameFold    = @"Fold";
NSString * const PLTransitionNameZoom    = @"Zoom";
NSString * const PLTransitionNameDynamic = @"UIKit Dynamics";

@interface PLTransitions ()
  @end

@implementation PLTransitions
  
#pragma mark - Public
  
- (NSArray *)all {
  if (_all) return _all;
  
  _all = @[@{ @"name" : PLTransitionNameDefault, @"transition" : [NSNull null] },
           @{ @"name" : PLTransitionNameFold,    @"transition" : self.foldAnimationController },
           @{ @"name" : PLTransitionNameZoom,    @"transition" : self.zoomAnimationController },
           @{ @"name" : PLTransitionNameDynamic, @"transition" : self.dynamicTransition }];
  
  return _all;
}
  
#pragma mark - Properties
  
- (PLFoldAnimationController *)foldAnimationController {
  if (_foldAnimationController) return _foldAnimationController;
  
  _foldAnimationController = [[PLFoldAnimationController alloc] init];
  
  return _foldAnimationController;
}
  
- (PLZoomAnimationController *)zoomAnimationController {
  if (_zoomAnimationController) return _zoomAnimationController;
  
  _zoomAnimationController = [[PLZoomAnimationController alloc] init];
  
  return _zoomAnimationController;
}
  
- (PLDynamicTransition *)dynamicTransition {
  if (_dynamicTransition) return _dynamicTransition;
  
  _dynamicTransition = [[PLDynamicTransition alloc] init];
  
  return _dynamicTransition;
}
  
  @end

