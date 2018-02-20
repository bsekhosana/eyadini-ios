//
//  PLUser.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/20.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLUser.h"

@implementation PLUser

/*
 * By default, tell JSONMODEL that all properties are optional
 */
+(BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
  self = [super initWithDictionary:dict error:err];
  
  if (self) {
    [[NSUserDefaults standardUserDefaults] setObject:self.username forKey:@"user.username"];
    [[NSUserDefaults standardUserDefaults] setObject:self.name forKey:@"user.name"];
    [[NSUserDefaults standardUserDefaults] setObject:self.surname forKey:@"user.surname"];
    [[NSUserDefaults standardUserDefaults] setObject:self.contactNumber forKey:@"user.contactNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:self.email forKey:@"user.email"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
  }
  
  return self;
}

+ (PLUser *)getCurrentUser{
  PLUser *user = [PLUser new];
  
  user.username = [[NSUserDefaults standardUserDefaults] objectForKey:@"user.username"];
  user.name = [[NSUserDefaults standardUserDefaults] objectForKey:@"user.name"];
  user.surname = [[NSUserDefaults standardUserDefaults] objectForKey:@"user.surname"];
  user.contactNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"user.contactNumber"];
  user.email = [[NSUserDefaults standardUserDefaults] objectForKey:@"user.email"];
  
  return user;
}

@end
