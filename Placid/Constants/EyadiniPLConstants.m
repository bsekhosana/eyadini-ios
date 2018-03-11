#if EYADINI
//
//  EyadiniPLConstants.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLConstants.h"

@implementation PLConstants

// --------------------------------------------------------------
// COLOUR LIBRARY
// --------------------------------------------------------------
+(UIColor *) LOOKUP_COLOUR1 {return [UIColor colorWithRed:78/255. green:19/255. blue:22/255. alpha:1.0];} // #4e1316
+(UIColor *) LOOKUP_COLOUR2 {return [UIColor colorWithRed:199/255. green:171/255. blue:157/255. alpha:1.0];} // #c7ab9d
+(UIColor *) LOOKUP_COLOUR3 {return [UIColor colorWithRed:247/255. green:123/255. blue:0/255. alpha:1.0];} // #F77B00
+(UIColor *) LOOKUP_COLOUR4 {return [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1.0];} // #000000
+(UIColor *) LOOKUP_COLOUR5 {return [UIColor colorWithRed:19/255. green:19/255. blue:19/255. alpha:1.0];} // #131313
+(UIColor *) LOOKUP_COLOUR6 {return [UIColor colorWithRed:35/255. green:35/255. blue:35/255. alpha:1.0];} // #3C3C3C
+(UIColor *) LOOKUP_COLOUR7 {return [UIColor colorWithRed:60/255. green:60/255. blue:60/255. alpha:1.0];} // #232323
+(UIColor *) LOOKUP_COLOUR8 {return [UIColor colorWithRed:132/255. green:132/255. blue:132/255. alpha:1.0];} // #848484
+(UIColor *) LOOKUP_COLOUR9 {return [UIColor colorWithRed:166/255. green:166/255. blue:166/255. alpha:1.0];} // #A6A6A6
+(UIColor *) LOOKUP_COLOUR10 {return [UIColor colorWithRed:201/255. green:201/255. blue:206/255. alpha:1.0];} // #C9C9CE
+(UIColor *) LOOKUP_COLOUR11 {return [UIColor colorWithRed:204/255. green:204/255. blue:204/255. alpha:1.0];} // #CCCCCC
+(UIColor *) LOOKUP_COLOUR12 {return [UIColor colorWithRed:226/255. green:226/255. blue:226/255. alpha:1.0];} // #E2E2E2
+(UIColor *) LOOKUP_COLOUR13 {return [UIColor colorWithRed:246/255. green:246/255. blue:246/255. alpha:1.0];} // #F6F6F6
+(UIColor *) LOOKUP_COLOUR14 {return [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1.0];} // #FFFFFF
+(UIColor *) LOOKUP_COLOUR15 {return [UIColor colorWithRed:0.36 green:0.71 blue:0.13 alpha:1];} // #FFFFFF
+(UIColor *) LOOKUP_COLOUR16 {return [UIColor colorWithRed:243/255. green:240/255. blue:238/255. alpha:1.0];} // #F3F0EE
+(UIColor *) LOOKUP_COLOUR17 {return [UIColor colorWithRed:85/255. green:193/255. blue:41/255. alpha:1.0];} // #55C129
+(UIColor *) LOOKUP_COLOUR18 {return [UIColor colorWithRed:171/255. green:169/255. blue:157/255. alpha:1.0];} // #ABA99D
+(UIColor *) LOOKUP_COLOUR19 {return [UIColor colorWithRed:134/255. green:134/255. blue:134/255. alpha:1.0];}  // #868686

// --------------------------------------------------------------
// FONT LIBRARY
// --------------------------------------------------------------

+ (UIFont *) LOOKUP_FONT1 { return [UIFont fontWithName:@"MyriadPro-Cond" size:1.0f];}
+ (UIFont *) LOOKUP_FONT1_BOLD { return [UIFont fontWithName:@"MyriadPro-BoldCond" size:1.0f];}
+ (UIFont *) LOOKUP_FONT2 { return [UIFont fontWithName:@"DINNextLTPro-MediumCond" size:1.0f];}
+ (UIFont *) LOOKUP_FONT2_BOLD { return [UIFont fontWithName:@"DINNextLTPro-MediumCond" size:1.0f];}
+ (UIFont *) LOOKUP_FONT3 { return [UIFont systemFontOfSize:0.0];;}
+ (UIFont *) LOOKUP_FONT3_BOLD { return [UIFont boldSystemFontOfSize:1.0];}
+ (UIFont *) LOOKUP_FONT4 { return [UIFont fontWithName:@"Fishaways-Regular" size:1.0f];}
+ (UIFont *) LOOKUP_FONT4_BOLD { return [UIFont fontWithName:@"Fishaways-Regular" size:1.0f];}
+ (UIFont *) LOOKUP_FONT5 { return [UIFont italicSystemFontOfSize:1.0];}
+ (UIFont *) LOOKUP_ICON_FONT {  return [UIFont fontWithName:@"FontAwesome" size:1.f];}
+ (UIFont *) LOOKUP_ICON_FONT:(float)size{ return [UIFont fontWithName:@"FontAwesome" size:size];}


+(UIColor *) COLOUR_TRANSPARENT { return [UIColor clearColor];}

# pragma mark colours - backgrounds - navigation

+(UIColor *) COLOUR_BG_NAV_PRIMARY { return [PLConstants LOOKUP_COLOUR1];}
+(UIColor *) COLOUR_BG_NAV_NOTIFICATION { return [PLConstants LOOKUP_COLOUR2];}

#pragma mark colours - labels - navigation

+(UIColor *) COLOUR_LBL_NAV_HEADING { return [PLConstants LOOKUP_COLOUR2];}
+(UIColor *) COLOUR_LBL_NAV_ACTION{ return [PLConstants LOOKUP_COLOUR2];}
+(UIColor *) COLOUR_LBL_NAV_ACTION_SELECTED{ return [[PLConstants COLOUR_LBL_NAV_ACTION] colorWithAlphaComponent:0.2];}
+(UIColor *) COLOUR_LBL_NAV_NOTIFICATION { return [PLConstants LOOKUP_COLOUR14];}


#pragma mark fonts - navigation

+ (UIFont *) FONT_NAV_HEADING { return [[PLConstants LOOKUP_FONT1_BOLD] fontWithSize:55*fontScaleFactor];}
+ (UIFont *) FONT_NAV_ACTION { return [[PLConstants LOOKUP_FONT3] fontWithSize:34*fontScaleFactor];}
+ (UIFont *) FONT_NAV_ICON { return [[PLConstants LOOKUP_ICON_FONT] fontWithSize:40*fontScaleFactor];}
+ (UIFont *) FONT_NAV_ACTION_SMALL { return [[PLConstants LOOKUP_FONT3] fontWithSize:20*fontScaleFactor];}
+ (UIFont *) FONT_NAV_NOTIFICATION  { return [[PLConstants LOOKUP_FONT3] fontWithSize:20*fontScaleFactor];}

#pragma mark fonts - headers

+ (UIFont *) FONT_NORMAL_HEADER { return [[PLConstants LOOKUP_FONT1] fontWithSize:40*fontScaleFactor];}

// MISC
+ (UIFont *) FONT_NORMAL_TEXT { return [[PLConstants LOOKUP_FONT1] fontWithSize:30*fontScaleFactor];}
+ (UIFont *) FONT_MEDIUM_NORMAL_TEXT { return [[PLConstants LOOKUP_FONT1] fontWithSize:40*fontScaleFactor];}
+ (UIFont *) FONT_LARGE_NORMAL_TEXT { return [[PLConstants LOOKUP_FONT1] fontWithSize:50*fontScaleFactor];}
+ (UIFont *) FONT_XLARGE_NORMAL_TEXT { return [[PLConstants LOOKUP_FONT1] fontWithSize:60*fontScaleFactor];}

+ (float) OS_VERSION {
  return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+(NSString *)navLogoImageName{
  return @"maxis_logo_large";
}

+(NSString *)PLApiKey{
    return [[NSBundle mainBundle] infoDictionary][@"PL_API_KEY"];
}


#pragma mark Font Awesome Icons

NSString *const FA_ICON_ANGLE_RIGHT = @"\uf105";
NSString *const FA_ICON_ANGLE_LEFT = @"\uf104";
NSString *const FA_ICON_CHEVRON_LEFT = @"\uf053";
NSString *const FA_ICON_CHEVRON_DOWN = @"\uf078";
NSString *const FA_ICON_BARS = @"\uf0c9";
NSString *const FA_ICON_CART = @"\uf07a";
NSString* const FA_ICON_USER = @"\uf007";
NSString* const FA_ICON_SEARCH = @"\uf002";
NSString* const FA_ICON_INFO = @"\uf05a";
NSString* const FA_ICON_TEL = @"\uf098";
NSString* const FA_ICON_LOCATION = @"\uf124";
NSString* const FA_ICON_TRASH = @"\uf1f8";
NSString* const FA_ICON_PENCIL = @"\uf044";
NSString* const FA_ICON_THUMBSUP = @"\uf087";
NSString* const FA_ICON_X_CIRCLE = @"\uf057";
NSString* const FA_ICON_CHECK_CIRCLE = @"\uf058";
NSString* const FA_ICON_LOCK = @"\uf023";
NSString* const FA_ICON_EXCLAMATION_CIRCLE = @"\uf06a";


@end
#endif
