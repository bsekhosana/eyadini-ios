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
#import "AFHTTPSessionManager.h"
#import "PLConstants.h"

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
  self.collectionViewController.navController = self.navigationController;
//  [self.collectionViewController configureCollectionViewLayout];
  self.collectionViewController.albumType = FacebookAlbum;
  [self.view addSubview:self.collectionViewController.view];
  
  
  __weak typeof(self) weakSelf = self;
  
  self.albums = [NSMutableArray new];
  // For more complex open graph stories, use `FBSDKShareAPI`
  // with `FBSDKShareOpenGraphContent`
  /* make the API call */
  
  
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSString *strURL = [@"https://graph.facebook.com/eyadiniloungenuz/albums?access_token=564202827266707|a142d6093609903a733d60797255520f&fields=created_time,picture,cover_photo,name" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id result) {
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

    [SVProgressHUD dismiss];
  } failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
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
