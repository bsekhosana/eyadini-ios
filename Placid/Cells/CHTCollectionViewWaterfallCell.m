//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallCell.h"

@implementation CHTCollectionViewWaterfallCell

#pragma mark - Accessors

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self = [[[NSBundle mainBundle] loadNibNamed:@"CHTCollectionViewWaterfallCell" owner:nil options:nil] objectAtIndex:0];
  }
  return self;
}

@end
