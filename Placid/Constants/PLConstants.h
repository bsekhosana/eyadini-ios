//
//  PLConstants.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static float fontScaleFactor = 0.5f;

@interface PLConstants : NSObject
// --------------------------------------------------------------
// COLOUR LIBRARY
// --------------------------------------------------------------
+(UIColor *) LOOKUP_COLOUR1;
+(UIColor *) LOOKUP_COLOUR2;
+(UIColor *) LOOKUP_COLOUR3;
+(UIColor *) LOOKUP_COLOUR4;
+(UIColor *) LOOKUP_COLOUR5;
+(UIColor *) LOOKUP_COLOUR6;
+(UIColor *) LOOKUP_COLOUR7;
+(UIColor *) LOOKUP_COLOUR8;
+(UIColor *) LOOKUP_COLOUR9;
+(UIColor *) LOOKUP_COLOUR10;
+(UIColor *) LOOKUP_COLOUR11;
+(UIColor *) LOOKUP_COLOUR12;
+(UIColor *) LOOKUP_COLOUR13;
+(UIColor *) LOOKUP_COLOUR14;
+(UIColor *) LOOKUP_COLOUR15;
+(UIColor *) LOOKUP_COLOUR16;
+(UIColor *) LOOKUP_COLOUR17;
+(UIColor *) LOOKUP_COLOUR18;
+(UIColor *) LOOKUP_COLOUR19;

// --------------------------------------------------------------
// FONT LIBRARY
// --------------------------------------------------------------

+ (UIFont *) LOOKUP_FONT1;
+ (UIFont *) LOOKUP_FONT1_BOLD;
+ (UIFont *) LOOKUP_FONT2;
+ (UIFont *) LOOKUP_FONT2_BOLD;
+ (UIFont *) LOOKUP_FONT3;
+ (UIFont *) LOOKUP_FONT3_BOLD;
+ (UIFont *) LOOKUP_FONT4;
+ (UIFont *) LOOKUP_FONT4_BOLD;
+ (UIFont *) LOOKUP_FONT5;
+ (UIFont *) LOOKUP_ICON_FONT;
+ (UIFont *) LOOKUP_ICON_FONT:(float)size;

+(UIColor *) COLOUR_TRANSPARENT;

# pragma mark colours - backgrounds - navigation

+(UIColor *) COLOUR_BG_NAV_PRIMARY;
+(UIColor *) COLOUR_BG_NAV_NOTIFICATION;

#pragma mark colours - labels - navigation

+(UIColor *) COLOUR_LBL_NAV_HEADING;
+(UIColor *) COLOUR_LBL_NAV_ACTION;
+(UIColor *) COLOUR_LBL_NAV_ACTION_SELECTED;
+(UIColor *) COLOUR_LBL_NAV_NOTIFICATION;

#pragma mark fonts - navigation

+ (UIFont *) FONT_NAV_HEADING;
+ (UIFont *) FONT_NAV_ACTION ;
+ (UIFont *) FONT_NAV_ICON;
+ (UIFont *) FONT_NAV_ACTION_SMALL;
+ (UIFont *) FONT_NAV_NOTIFICATION;

#pragma mark fonts - headers

+ (UIFont *) FONT_NORMAL_HEADER;

+(NSString *)navLogoImageName;

+(NSString *)PLApiKey;


#pragma mark Font Awesome icons

FOUNDATION_EXPORT NSString *const FA_ICON_ANGLE_RIGHT;
FOUNDATION_EXPORT NSString *const FA_ICON_ANGLE_LEFT;
FOUNDATION_EXPORT NSString *const FA_ICON_CHEVRON_LEFT;
FOUNDATION_EXPORT NSString *const FA_ICON_CHEVRON_DOWN;
FOUNDATION_EXPORT NSString *const FA_ICON_BARS;
FOUNDATION_EXPORT NSString *const FA_ICON_CART;
FOUNDATION_EXPORT NSString *const FA_ICON_USER;
FOUNDATION_EXPORT NSString *const FA_ICON_SEARCH;
FOUNDATION_EXPORT NSString *const FA_ICON_INFO;
FOUNDATION_EXPORT NSString *const FA_ICON_TEL;
FOUNDATION_EXPORT NSString *const FA_ICON_LOCATION;
FOUNDATION_EXPORT NSString *const FA_ICON_TRASH;
FOUNDATION_EXPORT NSString *const FA_ICON_PENCIL;
FOUNDATION_EXPORT NSString *const FA_ICON_THUMBSUP;
FOUNDATION_EXPORT NSString *const FA_ICON_X_CIRCLE;
FOUNDATION_EXPORT NSString *const FA_ICON_CHECK_CIRCLE;
FOUNDATION_EXPORT NSString *const FA_ICON_LOCK;
FOUNDATION_EXPORT NSString *const FA_ICON_EXCLAMATION_CIRCLE;

@end
