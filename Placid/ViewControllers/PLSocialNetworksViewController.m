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
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "PLInstagramTableViewController.h"
#import "PLTwitterViewController.h"
#import "AFHTTPSessionManager.h"

@interface PLSocialNetworksViewController ()
@property (strong, nonatomic) NSMutableArray *facebookPosts;
@property (strong, nonatomic) FBSDKLoginButton *loginButton;
@property (strong, nonatomic) PLInstagramTableViewController *instagramController;
@property (strong, nonatomic) PLTwitterViewController *twitterController;
@end

static NSString * facebookIdentifier = @"PLFacebookFeedTableViewCell";

@implementation PLSocialNetworksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [SVProgressHUD show];
    // Do any additional setup after loading the view.
  [self setupTopNavControls];
  
  [self.facebookTableView registerClass:[PLFacebookFeedTableViewCell class] forCellReuseIdentifier:facebookIdentifier];
  [self.facebookTableView registerNib:[UINib nibWithNibName:facebookIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:facebookIdentifier];
  self.facebookTableView.estimatedRowHeight = 180;
  self.facebookTableView.rowHeight = UITableViewAutomaticDimension;
  self.facebookTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
  [PLConstants ROUND_CONER_VIEW:self.waterMarkImageView];
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
  
  [self facebookSetup];
  
  [self instagramSetup];
  
  [self twitterSetup];
}

-(void)setupTopNavControls{
  [self.topViewNav setBackgroundColor:[PLConstants LOOKUP_COLOUR2]];
  [self.facebookButton setTitleColor:[PLConstants LOOKUP_COLOUR1] forState:UIControlStateNormal];
  [self.instagramButton setTitleColor:[PLConstants LOOKUP_COLOUR1] forState:UIControlStateNormal];
  [self.twitterButton setTitleColor:[PLConstants LOOKUP_COLOUR1] forState:UIControlStateNormal];
  
  [self.facebookButton.titleLabel setFont:[PLConstants FONT_LARGE_NORMAL_TEXT]];
  [self.instagramButton.titleLabel setFont:[PLConstants FONT_LARGE_NORMAL_TEXT]];
  [self.twitterButton.titleLabel setFont:[PLConstants FONT_LARGE_NORMAL_TEXT]];
  
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


-(void)instagramSetup{
  
  self.instagramController = [[PLInstagramTableViewController alloc]initWithNibName:@"PLInstagramTableViewController" bundle:[NSBundle mainBundle]];
  [self.instagramController.tableView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.instagramContainer.frame), CGRectGetHeight(self.instagramContainer.frame))];
  
  [self.instagramContainer addSubview:self.instagramController.tableView];
}

-(void)twitterSetup{
  
  self.twitterController = [[PLTwitterViewController alloc]initWithNibName:@"PLTwitterViewController" bundle:[NSBundle mainBundle]];
  
  [self.twitterController.view setFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight(self.facebookContainer.frame) + 80)];
  
  [self.twitterContainer addSubview:self.twitterController.view];
}

-(void)facebookSetup{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  __weak typeof(self) weakSelf = self;
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSString *strURL2 = [@"https://graph.facebook.com/eyadiniloungenuz/feed?access_token=564202827266707|a142d6093609903a733d60797255520f&fields=created_time, message,story,id,attachments{media},full_picture" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [manager GET:strURL2 parameters:nil progress:nil success:^(NSURLSessionTask *task, id result) {
    NSLog(@"Single Event Result : %@", result);
      NSError *error;
      self.facebookPosts = [NSMutableArray new];
      for (NSDictionary *dic in result[@"data"]) {
        PLFacebookFeedPost *post = [[PLFacebookFeedPost alloc]initWithDictionary:dic error:&error];
        post.imageSource = dic[@"full_picture"];
        [weakSelf.facebookPosts addObject:post];
      }

      [weakSelf.facebookTableView reloadData];
      [SVProgressHUD dismiss];
  } failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    [SVProgressHUD dismiss];
  }];
  
//  if ([FBSDKAccessToken currentAccessToken]) {
//    NSLog(@"Token : %@", [FBSDKAccessToken currentAccessToken]);
//    [self.loginButton removeFromSuperview];
//    self.loginButton = nil;
//    [self.view setNeedsDisplay];
//    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                  initWithGraphPath:@"/EyadiniLoungenuz/feed"
//                                  parameters:@{@"fields": @"created_time, message, story, id, attachments{media}"}
//                                  HTTPMethod:@"GET"];
//    __weak typeof(self) weakSelf = self;
//    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//      if (!error) {
//        NSError *error;
//        self.facebookPosts = [NSMutableArray new];
//        for (NSDictionary *dic in result[@"data"]) {
//          PLFacebookFeedPost *post = [[PLFacebookFeedPost alloc]initWithDictionary:dic error:&error];
//          post.imageSource = dic[@"attachments"][@"data"][0][@"media"][@"image"][@"src"];
//          [weakSelf.facebookPosts addObject:post];
//        }
//        
//        [weakSelf.facebookTableView reloadData];
//        [SVProgressHUD dismiss];
//      }
//      
//    }];
//  }else{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(facebookSetup)
//                                                 name:FBSDKAccessTokenDidChangeNotification
//                                               object:nil];
//    
//    self.loginButton = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
//    [self.facebookContainer addSubview:self.loginButton];
//    self.loginButton.center =  CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) * 0.15f);
//    [self.loginButton setHidden:NO];
//  }
}

#pragma mark - Facebook Datasource & Delagate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  PLFacebookFeedTableViewCell *cell = (PLFacebookFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:facebookIdentifier forIndexPath:indexPath];
  
  if (cell) {
    PLFacebookFeedPost * post = [self.facebookPosts objectAtIndex:indexPath.row];
    [cell clearLabels];
    [cell.createdTimeLabel setText:post.created_time];
    [cell.storyLabel setText:post.story];
    [cell.messageLabel setText:post.message];
    if (post.imageSource) {
      [cell.feedImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:post.imageSource]] placeholderImage:[UIImage imageNamed:@"eyadini_nav_logo"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        [cell.feedImageView setImage:[PLConstants imageWithImage:image scaledToMaxWidth: CGRectGetWidth(cell.feedImageView.frame) maxHeight: CGRectGetHeight(cell.feedImageView.frame)]];
      } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
      
      }];
    }
  }
  
  [cell.facebookPlaceholderImageView setHidden:self.facebookPosts.count > 0];
  
  return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.facebookPosts.count > 0 ? self.facebookPosts.count : 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewAutomaticDimension;
}

@end
