//
//  PLInstagramFeed.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/04/24.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "JSONModel.h"

@interface PLInstagramFeed : JSONModel
@property (strong, nonatomic) NSDictionary *caption, *likes, *comments, *images;
@end
