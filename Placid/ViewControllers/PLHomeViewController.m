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
#import "PLSponsor.h"
#import "PLConstants.h"
#import "PLFacebookFeedPost.h"
#import <UIImageView+AFNetworking.h>
#import "AFHTTPSessionManager.h"

@interface PLHomeViewController()
@property (weak, nonatomic) IBOutlet UILabel *noNewsToDisplayLable;
@property (weak, nonatomic) IBOutlet UILabel *noEventsTODisplay;
@property (nonatomic, strong) NSMutableArray *iCarouselItems;
@end


@implementation PLHomeViewController

  
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setIsHomeScreen];
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
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSString *strURL = [@"https://graph.facebook.com/eyadiniloungenuz/events?access_token=564202827266707|a142d6093609903a733d60797255520f&fields=start_time,place,cover,name,description&limit=1" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id result) {
    NSLog(@"Single Event Result : %@", result);
    
  } failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    [SVProgressHUD dismiss];
  }];
  
  
  NSString *strURL2 = [@"https://graph.facebook.com/eyadiniloungenuz/feed?access_token=564202827266707|a142d6093609903a733d60797255520f&fields=created_time, message,story,id,attachments{media},full_picture&limit=1" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [manager GET:strURL2 parameters:nil progress:nil success:^(NSURLSessionTask *task, id result) {
    NSLog(@"Single Event Result : %@", result);
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
  } failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
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
  
-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  self.carouselContainer.autoscroll = -0.2;

}
  
-(BOOL)prefersStatusBarHidden{
  return NO;
}

  
@end

