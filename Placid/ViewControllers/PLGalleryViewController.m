//
//  PLGalleryViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLGalleryViewController.h"
#import <FBSDKCoreKit.h>

@interface PLGalleryViewController ()

@end

@implementation PLGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"Gallery";
  
  // For more complex open graph stories, use `FBSDKShareAPI`
  // with `FBSDKShareOpenGraphContent`
  /* make the API call */
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"/eyadini/albums"
                                parameters:@{}
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        id result,
                                        NSError *error) {
    NSLog(@"Albums Results : %@", result);
    // Handle the result
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
