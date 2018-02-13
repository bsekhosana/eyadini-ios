//
//  UIImage+PLShadow.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "UIImage+PLShadow.h"

@implementation UIImage (PLShadow)

+ (UIImage *)imageWithContentsOfFile:(NSString *)path withShadow:(BOOL)applyShadow {
  UIImage *image = [UIImage imageWithContentsOfFile:path];
  if (!applyShadow) {
    return image;
  }
  
  return [UIImage applyShadow:image];
}

+ (UIImage *)imageNamed:(NSString *)name withShadow:(BOOL)applyShadow
{
  UIImage *image = [UIImage imageNamed:name];
  if (!image) {
    return image;
  }
  if (!applyShadow) {
    return image;
  }
  
  return [UIImage applyShadow:image];
}

+ (UIImage *)applyShadow:(UIImage *)theImage
{
  UIGraphicsBeginImageContext(CGSizeMake(theImage.size.width + 12, theImage.size.height + 12));
  CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(6.0f, -6.0f), 6.0f);
  [theImage drawAtPoint:CGPointZero];
  UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return result;
}

@end
