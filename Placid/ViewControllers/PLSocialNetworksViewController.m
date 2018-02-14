//
//  PLSocialNetworksViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/14.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLSocialNetworksViewController.h"
#import "PLConstants.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "PLFacebookFeedPost.h"
#import "PLFacebookFeedTableViewCell.h"

@interface PLSocialNetworksViewController ()
@property (strong, nonatomic) NSMutableArray *facebookPosts;
@end

static NSString * facebookIdentifier = @"PLFacebookFeedTableViewCell";

@implementation PLSocialNetworksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self setupTopNavControls];
  
  [self facebookSetup];
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

-(void)setupTopNavControls{
  [self.topViewNav setBackgroundColor:[PLConstants LOOKUP_COLOUR2]];
  [self.facebookButton setTitleColor:[PLConstants LOOKUP_COLOUR1] forState:UIControlStateNormal];
  [self.instagramButton setTitleColor:[PLConstants LOOKUP_COLOUR1] forState:UIControlStateNormal];
  [self.twitterButton setTitleColor:[PLConstants LOOKUP_COLOUR1] forState:UIControlStateNormal];
  
  [self.facebookButton.titleLabel setFont:[PLConstants FONT_NORMAL_HEADER]];
  [self.instagramButton.titleLabel setFont:[PLConstants FONT_NORMAL_HEADER]];
  [self.twitterButton.titleLabel setFont:[PLConstants FONT_NORMAL_HEADER]];
  
  [self.bottomDividerView setBackgroundColor:[PLConstants LOOKUP_COLOUR1]];
  
}
- (IBAction)didSelectTopNavButton:(UIButton *)sender {
  int bottomDividerConstant = 0;
  int faceBookLeadingConstant = 0;
  switch (sender.tag) {
    case 0:
      NSLog(@"Facebook");
      break;
    case 1:
      NSLog(@"Instagram");
      bottomDividerConstant = CGRectGetMinX(self.instagramButton.frame);
      faceBookLeadingConstant = -CGRectGetWidth(self.facebookContainer.frame);
      break;
    case 2:
      NSLog(@"Twitter");
      bottomDividerConstant = CGRectGetMinX(self.twitterButton.frame)+8;
      faceBookLeadingConstant = -(CGRectGetWidth(self.facebookContainer.frame)*2);
      break;
    default:
      break;
  }
  
  [self.view layoutIfNeeded];
  self.bottomDividerLeadingConstraint.constant = bottomDividerConstant;
  self.facebookCOntainerLeadingConstraint.constant = faceBookLeadingConstant;
  [UIView animateWithDuration:0.2
                   animations:^{
                     [self.view layoutIfNeeded]; // Called on parent view
                   }];
}


-(void)facebookSetup{
  [self.facebookTableView registerClass:[PLFacebookFeedTableViewCell class] forCellReuseIdentifier:facebookIdentifier];
  [self.facebookTableView registerNib:[UINib nibWithNibName:facebookIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:facebookIdentifier];
  if ([FBSDKAccessToken currentAccessToken]) {
    NSLog(@"Token : %@", [FBSDKAccessToken currentAccessToken]);
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/eyadini/feed"
                                  parameters:@{@"fields": @"created_time, message, story, id"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
      if (!error) {
        NSError *error;
        self.facebookPosts = [NSMutableArray new];
        for (NSDictionary *dic in result[@"data"]) {
          PLFacebookFeedPost *post = [[PLFacebookFeedPost alloc]initWithDictionary:dic error:&error];
          [self.facebookPosts addObject:post];
        }
      }
      
    }];
  }else{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    
    [self.view addSubview:loginButton];
    loginButton.center = self.view.center;
  }
  
  
  
//  if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
//    [[[FBSDKGraphRequest alloc]
//      initWithGraphPath:@"eyadini/feed"
//      parameters: nil
//      HTTPMethod:@"GET"]
//     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//       if (!error) {
//         NSLog(@"Posts :%@", result);
//       }
//     }];
//  }
  
}


#pragma mark - Facebook Datasource & Delagate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  PLFacebookFeedTableViewCell *cell = (PLFacebookFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:facebookIdentifier forIndexPath:indexPath];
  
  if (cell) {
    PLFacebookFeedPost * post = [self.facebookPosts objectAtIndex:indexPath.row];
  }
  
  [cell.facebookPlaceholderImageView setHidden:self.facebookPosts.count > 0];
  
  return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.facebookPosts.count > 0 ? self.facebookPosts.count : 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 110;
}

@end
