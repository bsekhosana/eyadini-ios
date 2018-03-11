//
//  PLFacebookAlbum.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/03/09.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "JSONModel.h"

@interface PLFacebookAlbum : JSONModel
@property (strong, nonatomic) NSString *id, *name, *created_time, *pictureUrl;
@end
