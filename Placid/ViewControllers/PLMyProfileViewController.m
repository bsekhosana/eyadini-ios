//
//  PLMyProfileViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/14.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLMyProfileViewController.h"
#import <PureLayout/PureLayout.h>
#import "UIImageView+Letters.h"
#import <QuartzCore/QuartzCore.h>
#import "PLUser.h"
#import "PLProfileTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@interface PLMyProfileViewController ()
@property (strong, nonatomic) UIImageView *headerProfile;
@property (strong, nonatomic) PLUser *currentUser;
@end

static NSString *CellIdentifier = @"PLProfileTableViewCell";

@implementation PLMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.currentUser = [PLUser getCurrentUser];
  
  int headerViewHeight = CGRectGetHeight(self.view.frame)*0.4;
  
  [self.tableView registerClass:[PLProfileTableViewCell class] forCellReuseIdentifier:CellIdentifier];
  [self.view setBackgroundColor:[PLConstants LOOKUP_COLOUR2]];
  
  
  UIView *header = [UIView new];
  UIImageView *headerView = [UIImageView new];
  if (self.currentUser.coverPage) {
    [headerView setImageWithURL:[NSURL URLWithString:self.currentUser.coverPage]];
  }else{
    headerView.image = [UIImage imageNamed:@"ey2.jpg"];
  }
  
  headerView.contentMode = UIViewContentModeScaleAspectFill;
  
  [header addSubview:headerView];
  [headerView autoPinEdgesToSuperviewEdges];
  
  
  UIImageView *myImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.view.frame)*0.3, CGRectGetWidth(self.view.frame)*0.3)];
  [header addSubview:myImgView];
  if (self.currentUser.profilePic) {
    [myImgView setImageWithURL:[NSURL URLWithString:self.currentUser.profilePic]];
    [myImgView autoSetDimension:ALDimensionWidth toSize:headerViewHeight*0.4];
    [myImgView autoSetDimension:ALDimensionHeight toSize:headerViewHeight*0.4];
    [myImgView setContentMode:UIViewContentModeScaleAspectFit];
    myImgView.layer.cornerRadius = CGRectGetWidth(myImgView.frame)/2;
    myImgView.layer.masksToBounds = true;
    
    UIImageView *wrapAround = [UIImageView new];
    [wrapAround setBackgroundColor:[PLConstants LOOKUP_COLOUR1]];
    [wrapAround autoSetDimension:ALDimensionWidth toSize:headerViewHeight*0.43];
    [wrapAround autoSetDimension:ALDimensionHeight toSize:headerViewHeight*0.43];
    [header addSubview:wrapAround];
    [header bringSubviewToFront:myImgView];
    wrapAround.layer.cornerRadius = CGRectGetWidth(wrapAround.frame)/2;
    wrapAround.layer.masksToBounds = true;
    
    [wrapAround autoCenterInSuperview];
    
    
  }else{
    [myImgView setImageWithString:self.currentUser.name color:nil circular:YES];
  }
 
  [myImgView autoCenterInSuperview];
  
  // Parallax Header
  self.tableView.parallaxHeader.view = header; // You can set the parallax header view from the floating view.
  self.tableView.parallaxHeader.height = headerViewHeight;
  self.tableView.parallaxHeader.mode = MXParallaxHeaderModeFill;
  self.tableView.parallaxHeader.delegate = self;
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

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  self.tableView.parallaxHeader.minimumHeight = self.topLayoutGuide.length;
}

#pragma mark <MXParallaxHeaderDelegate>

- (void)parallaxHeaderDidScroll:(MXParallaxHeader *)parallaxHeader {
  NSLog(@"progress %f", parallaxHeader.progress);
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.currentUser toDictionary] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  PLProfileTableViewCell *cell = [[PLProfileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  [cell setBackgroundColor:[UIColor clearColor]];

  NSString *text = @"";
  switch (indexPath.row) {
    case 0:
      text = self.currentUser.username;
      break;
    case 1:
      text = self.currentUser.name;
      break;
    case 2:
      text = self.currentUser.email;
      break;
    case 3:
      text = self.currentUser.contactNumber;
      break;
    default:
      break;
  }
  cell.titleCellLabel.text = text;
  return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70;
}

@end
