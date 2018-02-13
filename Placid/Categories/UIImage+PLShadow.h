//
//  UIImage+PLShadow.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PLShadow)
+ (UIImage *)imageWithContentsOfFile:(NSString *)path withShadow:(BOOL)applyShadow;

+ (UIImage *)imageNamed:(NSString *)name withShadow:(BOOL)applyShadow;

+ (UIImage *)applyShadow:(UIImage *)theImage;
@end
