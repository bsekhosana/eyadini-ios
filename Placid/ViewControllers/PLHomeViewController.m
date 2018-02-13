//
//  PLHomeViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLHomeViewController.h"

#import "PLDynamicTransition.h"
#import "UIViewController+ECSlidingViewController.h"
#import "PLDynamicTransition.h"
#import "PLTransitions.h"

@interface PLHomeViewController()

@end


@implementation PLHomeViewController
  
- (void)viewDidLoad {
  [super viewDidLoad];

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
  
  
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
}

  
-(BOOL)prefersStatusBarHidden{
  return NO;
}
  
  
  
  @end

