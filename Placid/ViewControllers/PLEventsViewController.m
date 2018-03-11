//
//  PLEventsViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLEventsViewController.h"
#import "PLCHTCollectionViewController.h"
#import <FBSDKCoreKit.h>

@interface PLEventsViewController ()
@property (strong, nonatomic) PLCHTCollectionViewController *collectionViewController;
@end

@implementation PLEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"Events";
  
  self.collectionViewController = [PLCHTCollectionViewController new];
  [self.collectionViewController.view setFrame:self.view.frame];
  [self.collectionViewController configureCollectionViewLayout];
  [self.view addSubview:self.collectionViewController.view];
  
  // For more complex open graph stories, use `FBSDKShareAPI`
  // with `FBSDKShareOpenGraphContent`
  /* make the API call */
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"/maxslifestyle/events"
                                parameters:@{}
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        id result,
                                        NSError *error) {
    NSLog(@"Events Results : %@", result);
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
