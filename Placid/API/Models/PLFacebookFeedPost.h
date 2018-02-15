//
//  PLFacebookFeedPost.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/15.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "JSONModel.h"

@interface PLFacebookFeedPost : JSONModel
@property (strong, nonatomic) NSString *id, *story, *message, *created_time, *imageSource;
@end
