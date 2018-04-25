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
#import "PLLoginViewController.h"
#import "PLSponsor.h"
#import "PLConstants.h"
#import "PLFacebookFeedPost.h"
#import <UIImageView+AFNetworking.h>

@interface PLHomeViewController()
@property (strong, nonatomic) PLLoginViewController *loginController;
@property (weak, nonatomic) IBOutlet UILabel *noNewsToDisplayLable;
@property (weak, nonatomic) IBOutlet UILabel *noEventsTODisplay;
@property (nonatomic, strong) NSMutableArray *iCarouselItems;
@end


@implementation PLHomeViewController

  
- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[PLConstants LOOKUP_COLOUR2]];
  [self.carouselDividerView setBackgroundColor:[[PLConstants LOOKUP_COLOUR1] colorWithAlphaComponent:0.3]];
  _iCarouselItems = [[NSMutableArray alloc]init];
  
  NSError *error;
  PLSponsor *castleLager = [[PLSponsor alloc]initWithDictionary:@{@"name":@"Castle Lager",@"image":@"castle_lager",@"url":@"http://www.castlelager.co.za/"} error:&error];
  PLSponsor *castleLite = [[PLSponsor alloc]initWithDictionary:@{@"name":@"Castle Lite",@"image":@"castle_lite",@"url":@"https://www.castlelite.co.za/"} error:&error];
  PLSponsor *heineken = [[PLSponsor alloc]initWithDictionary:@{@"name":@"Heineken",@"image":@"heineken",@"url":@"http://www.theheinekencompany.com/"} error:&error];
  PLSponsor *savanna = [[PLSponsor alloc]initWithDictionary:@{@"name":@"Savanna",@"image":@"savanna",@"url":@"https://savannacider.com"} error:&error];
  PLSponsor *landRover = [[PLSponsor alloc]initWithDictionary:@{@"name":@"Land Rover",@"image":@"land_rover",@"url":@"https://www.landrover.co.za"} error:&error];
  PLSponsor *fnb = [[PLSponsor alloc]initWithDictionary:@{@"name":@"FNB",@"image":@"fnb",@"url":@"https://www.fnb.co.za/"} error:&error];
  
  [_iCarouselItems addObjectsFromArray:@[castleLager, castleLite, heineken, savanna, landRover, fnb]];
  
  self.carouselContainer.dataSource = self;
  
  self.carouselContainer.delegate = self;
  
  self.carouselContainer.type = iCarouselTypeLinear;
  
  self.latestNewsContainerView.layer.cornerRadius = 10;
  self.latestNewsContainerView.layer.masksToBounds = true;
  
  self.upCommingEventsCOntainerView.layer.cornerRadius = 10;
  self.upCommingEventsCOntainerView.layer.masksToBounds = true;
  
  
  
  __weak typeof(self) weakSelf = self;
  
  // For more complex open graph stories, use `FBSDKShareAPI`
  // with `FBSDKShareOpenGraphContent`
  /* make the API call */
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"/eyadini/events?limit=1"
                                parameters:@{@"fields":@"cover, name, place, start_time"}
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        NSDictionary * result,
                                        NSError *error) {
    NSLog(@"Events Results : %@", result);
    // Handle the result
    if ([result[@"data"] count] > 0) {
      [weakSelf.noEventsTODisplay setHidden:YES];
      [weakSelf.eventLabel setHidden:NO];
      [weakSelf.eventImageView setHidden:NO];
      [weakSelf.eventLabel setText:result[@"data"][0][@"name"]];
      [weakSelf.eventImageView setImageWithURL:[NSURL URLWithString:result[@"data"][0][@"cover"][@"source"]] placeholderImage:[UIImage imageNamed:@"eyadini_nav_logo"]];
    }else{
      [weakSelf.noEventsTODisplay setHidden:NO];
      [weakSelf.eventLabel setHidden:YES];
      [weakSelf.eventImageView setHidden:YES];
    }
    
  }];
  
  
  FBSDKGraphRequest *newRequest = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"/eyadini/feed?limit=1"
                                parameters:@{@"fields": @"created_time, message, story, id, attachments{media}, full_picture"}
                                HTTPMethod:@"GET"];
  [newRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
    if (!error) {
      NSError *error;
      
      if ([result[@"data"] count] > 0) {
        [weakSelf.noNewsToDisplayLable setHidden:YES];
        [weakSelf.latestNewLabel setHidden:NO];
        [weakSelf.latestNewsImage setHidden:NO];
        PLFacebookFeedPost *post = [[PLFacebookFeedPost alloc]initWithDictionary:result[@"data"][0] error:&error];
        post.imageSource = result[@"data"][0][@"full_picture"];
        [weakSelf.latestNewsImage setImageWithURL:[NSURL URLWithString:post.imageSource] placeholderImage:[UIImage imageNamed:@"eyadini_nav_logo"]];
        
        [weakSelf.latestNewLabel setText:post.message];
      }else{
        [weakSelf.noNewsToDisplayLable setHidden:NO];
        [weakSelf.latestNewLabel setHidden:YES];
        [weakSelf.latestNewsImage setHidden:YES];
      }
    }
    
  }];

}


#pragma mark iCarousel methods

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
  return [_iCarouselItems count];
}


-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
  if (view == nil)
    
  {
  
    PLSponsor *sponsor = [_iCarouselItems objectAtIndex:index];
    
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.carouselContainer.frame)*0.8, CGRectGetHeight(self.carouselContainer.frame)*0.9)];
    
    ((UIImageView *)view).image = [UIImage imageNamed:sponsor.image];
    
    view.contentMode = UIViewContentModeScaleAspectFit;
    
  }
  
  
  return view;
}

-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
  if (option == iCarouselOptionWrap) {
    return 1;
  }
  
  return value * 1.7;
}


-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
  NSLog(@"Selected carousel index is %ld",(long)index);
  
  PLSponsor *sponsor = [_iCarouselItems objectAtIndex:index];
  
  if ([PLConstants OS_VERSION] > 10) {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:sponsor.url] options:@{} completionHandler:nil];
  }else{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:sponsor.url]];
  }
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
  BOOL isLoggedIn = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedIn"];

  if (!isLoggedIn) {
    self.slidingViewController.panGesture.enabled = NO;
    self.loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"PLLoginViewController"];
    [self.navigationController pushViewController:self.loginController animated:YES];
  }else{
    self.slidingViewController.panGesture.enabled = YES;
  }
}


-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  self.carouselContainer.autoscroll = -0.2;

}
  
-(BOOL)prefersStatusBarHidden{
  return NO;
}

  
@end

