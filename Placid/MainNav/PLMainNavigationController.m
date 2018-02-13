//
//  PLMainNavigationController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLMainNavigationController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "PLMainNavTableViewCell.h"
#import "PLConstants.h"
#import "UIImage+PLShadow.h"

@interface PLMainNavigationController ()
  @property (nonatomic, strong) NSArray *menuItems;
  @property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@end

static NSString *CellIdentifier = @"PLMainNavTableViewCell";
@implementation PLMainNavigationController
  
- (void)viewDidLoad {
  [super viewDidLoad];
  
  // topViewController is the transitions navigation controller at this point.
  // It is initially set as a User Defined Runtime Attributes in storyboards.
  // We keep a reference to this instance so that we can go back to it without losing its state.
  self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
  
  [self.tableView registerClass:[PLMainNavTableViewCell class] forCellReuseIdentifier:CellIdentifier];
  
  [self.view setBackgroundColor:[PLConstants LOOKUP_COLOUR2]];
  [self.navLogoImageView setImage:[UIImage imageNamed:[PLConstants navLogoImageName]]];
  [self.navLogoImageView setContentMode:UIViewContentModeScaleAspectFit];
  
}
  
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.view endEditing:YES];
}
   
#pragma mark - Properties
  
- (NSArray *)menuItems {
  if (_menuItems) return _menuItems;
  
  _menuItems = @[@"Home", @"Events", @"Gallery",@"Cuisine", @"Blog", @"About Us", @"Contact Us"];
  
  return _menuItems;
}
  
#pragma mark - UITableViewDataSource
  
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.menuItems.count;
}
  
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PLMainNavTableViewCell *cell = [[PLMainNavTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  
  NSString *menuItem = self.menuItems[indexPath.row];
  
  cell.navTitleLabel.text = menuItem;
  [cell setBackgroundColor:[UIColor clearColor]];
  
  return cell;
}
  
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60;
}
  
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
  NSString *menuItem = self.menuItems[selectedIndexPath.row];
  NSLog(@"%@", menuItem);
  // This undoes the Zoom Transition's scale because it affects the other transitions.
  // You normally wouldn't need to do anything like this, but we're changing transitions
  // dynamically so everything needs to start in a consistent state.
  self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
  

  if ([menuItem isEqualToString:@"Home"]) {
    self.slidingViewController.topViewController = self.transitionsNavigationController;
  }else{
      self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:[[NSString stringWithFormat:@"PL%@NavigationViewController", menuItem] stringByReplacingOccurrencesOfString:@" " withString:@""]];

  }
  
  [self.slidingViewController resetTopViewAnimated:YES];
}
  
  @end

