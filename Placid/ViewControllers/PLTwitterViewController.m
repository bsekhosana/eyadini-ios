//
//  PLTwitterViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/04/24.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLTwitterViewController.h"

@interface PLTwitterViewController ()

@end

@implementation PLTwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
  self.dataSource = [[TWTRUserTimelineDataSource alloc] initWithScreenName:@"eyadini" APIClient:client];
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