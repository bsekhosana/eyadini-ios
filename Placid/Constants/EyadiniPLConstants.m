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
    
+(NSString *)PLApiKey{
    return [[NSBundle mainBundle] infoDictionary][@"PL_API_KEY"];
}
    
@end
#endif
