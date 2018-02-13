//
//  PLMainNavigationController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLMainNavigationController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface PLMainNavigationController ()
  @property (nonatomic, strong) NSArray *menuItems;
  @property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@end



@implementation PLMainNavigationController
  
- (void)viewDidLoad {
  [super viewDidLoad];
  
  // topViewController is the transitions navigation controller at this point.
  // It is initially set as a User Defined Runtime Attributes in storyboards.
  // We keep a reference to this instance so that we can go back to it without losing its state.
  self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
}
  
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.view endEditing:YES];
}
  
#pragma mark - Properties
  
- (NSArray *)menuItems {
  if (_menuItems) return _menuItems;
  
  _menuItems = @[@"Transitions", @"Settings"];
  
  return _menuItems;
}
  
#pragma mark - UITableViewDataSource
  
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.menuItems.count;
}
  
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"PLMenuCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  NSString *menuItem = self.menuItems[indexPath.row];
  
  cell.textLabel.text = menuItem;
  [cell setBackgroundColor:[UIColor clearColor]];
  
  return cell;
}
  
#pragma mark - UITableViewDelegate
  
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *menuItem = self.menuItems[indexPath.row];
  
  // This undoes the Zoom Transition's scale because it affects the other transitions.
  // You normally wouldn't need to do anything like this, but we're changing transitions
  // dynamically so everything needs to start in a consistent state.
  self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
  
  if ([menuItem isEqualToString:@"Transitions"]) {
    self.slidingViewController.topViewController = self.transitionsNavigationController;
  } else if ([menuItem isEqualToString:@"Settings"]) {
    self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MESettingsNavigationController"];
  }
  
  
  [self.slidingViewController resetTopViewAnimated:YES];
}
  
  @end
