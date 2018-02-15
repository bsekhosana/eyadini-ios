//
//  PLContactUsViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLContactUsViewController.h"
#import "PLConstants.h"

@interface PLContactUsViewController ()

@property (strong, nonatomic) AAShareBubbles *shareBubbles;
@property CGFloat radius;
@property CGFloat bubbleRadius;

@end

@implementation PLContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"Contact Us";
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showShareBubbles)];
  [tap setNumberOfTapsRequired:1];
  [tap setNumberOfTouchesRequired:1];
  [self.centerContactUsImageView addGestureRecognizer:tap];
  [self.centerContactUsImageView setUserInteractionEnabled:YES];
  
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  [self showShareBubbles];
}

-(void)showShareBubbles{
  self.radius = 170;
  self.bubbleRadius = 50;
  
  if(self.shareBubbles) {
    self.shareBubbles = nil;
  }
  self.shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(CGRectGetWidth(self.view.frame)/2, self.centerContactUsImageView.center.y) radius:self.radius inView:self.view];
  self.shareBubbles.delegate = self;
  self.shareBubbles.bubbleRadius = self.bubbleRadius;
  self.shareBubbles.showFacebookBubble = YES;
  self.shareBubbles.showTwitterBubble = YES;
  self.shareBubbles.showGooglePlusBubble = NO;
  self.shareBubbles.showTumblrBubble = NO;
  self.shareBubbles.showVkBubble = NO;
  self.shareBubbles.showLinkedInBubble = NO;
  self.shareBubbles.showYoutubeBubble = YES;
  self.shareBubbles.showVimeoBubble = NO;
  self.shareBubbles.showRedditBubble = NO;
  self.shareBubbles.showPinterestBubble = NO;
  self.shareBubbles.showInstagramBubble = YES;
  self.shareBubbles.showWhatsappBubble = YES;
  
  [self.shareBubbles show];
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

-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
  
  NSString *urlString = @"";
  switch (bubbleType) {
    case AAShareBubbleTypeFacebook:{
      NSLog(@"Facebook");
      urlString = @"https://www.facebook.com/eyadini";
      break;
    }
    case AAShareBubbleTypeTwitter:{
      NSLog(@"Twitter");
      urlString = @"https://twitter.com/eyadini";
      break;
    }
    case AAShareBubbleTypeGooglePlus:{
      NSLog(@"Google+");
      urlString = @"";
      break;
    }
    case AAShareBubbleTypeTumblr:{
      NSLog(@"Tumblr");
      break;
    }
    case AAShareBubbleTypeVk:{
      NSLog(@"Vkontakte (vk.com)");
      break;
    }
    case AAShareBubbleTypeLinkedIn:{
      NSLog(@"LinkedIn");
      break;
    }
    case AAShareBubbleTypeYoutube:{
      NSLog(@"Youtube");
      urlString = @"";
      break;
    }
    case AAShareBubbleTypeVimeo:{
      NSLog(@"Vimeo");
      break;
    }
    case AAShareBubbleTypeInstagram:{
      NSLog(@"Instagram");
      urlString = @"https://www.instagram.com/eyadiniloungenuz/";
      break;
    }
    default:
      break;
  }
  
  NSURL *url = [NSURL URLWithString:urlString];
  if ([PLConstants OS_VERSION] >= 10) {
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
  }else{
    [[UIApplication sharedApplication] openURL:url];
  }
  
}

@end
