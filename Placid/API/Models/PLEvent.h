//
//  PLEvent.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/03/12.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "JSONModel.h"

@interface PLEvent : JSONModel
@property (strong, nonatomic) NSString *id, *name,  *start_time, *imageUrl;
@property (strong, nonatomic) NSDictionary *location;
@end
