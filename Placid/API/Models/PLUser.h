//
//  PLUser.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/20.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "JSONModel.h"

@interface PLUser : JSONModel
@property (strong, nonatomic) NSString *id, *username, *name, *surname, *email, *contactNumber;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;
+ (PLUser *)getCurrentUser;
@end
