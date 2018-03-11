//
//  PLCHTCollectionViewController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/03/09.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"

typedef enum {
  FacebookAlbum,
  InstagramAlbum,
  TwitterAlbum
} AlbumType;

@interface PLCHTCollectionViewController : UICollectionViewController
@property (nonatomic, strong) NSArray *data;
@property (nonatomic) AlbumType *albumType;
-(void)configureCollectionViewLayout;

@end
