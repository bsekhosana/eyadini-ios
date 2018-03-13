//
//  PLGalleryViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLGalleryViewController.h"
#import "PLCHTCollectionViewController.h"
#import "PLFacebookAlbum.h"
#import <FBSDKCoreKit.h>

@interface PLGalleryViewController ()
@property (strong, nonatomic) PLCHTCollectionViewController *collectionViewController;
@property (strong, nonatomic) NSMutableArray *albums;
@end

@implementation PLGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"Gallery";
  
  [SVProgressHUD show];
  
  CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
  
  layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
  layout.headerHeight = 15;
  layout.footerHeight = 10;
  layout.minimumColumnSpacing = 20;
  layout.minimumInteritemSpacing = 30;
  
  self.collectionViewController = [[PLCHTCollectionViewController alloc]initWithCollectionViewLayout:layout];
  [self.collectionViewController.view setFrame:self.view.frame];
//  [self.collectionViewController configureCollectionViewLayout];
  self.collectionViewController.albumType = FacebookAlbum;
  [self.view addSubview:self.collectionViewController.view];
  
  
  __weak typeof(self) weakSelf = self;
  
  self.albums = [NSMutableArray new];
  // For more complex open graph stories, use `FBSDKShareAPI`
  // with `FBSDKShareOpenGraphContent`
  /* make the API call */
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"/maxslifestyle/albums"
                                parameters:@{@"fields": @"picture, cover_photo"}
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        NSDictionary * result,
                                        NSError *error) {
    NSLog(@"Albums Results : %@", result);
    // Handle the result
    
    for (int i = 0; i < [result[@"data"] count]; i++) {
      NSLog(@"Data : %@", result[@"data"][i]);
      PLFacebookAlbum *album = [PLFacebookAlbum new];
      album.id = result[@"data"][i][@"id"];
      album.name = result[@"data"][i][@"cover_photo"][@"name"];
      album.created_time = result[@"data"][i][@"cover_photo"][@"created_time"];
      album.pictureUrl = result[@"data"][i][@"picture"][@"data"][@"url"];
      [weakSelf.albums addObject:album];
    }
    
    
    weakSelf.collectionViewController.data = [weakSelf.albums copy];
    [weakSelf.collectionViewController.collectionView reloadData];
    [SVProgressHUD dismiss];
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
