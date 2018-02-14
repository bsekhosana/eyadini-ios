//
//  PLSocialNetworksViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/14.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLSocialNetworksViewController.h"
#import "PLConstants.h"

@interface PLSocialNetworksViewController ()

@end

@implementation PLSocialNetworksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self setupTopNavControls];
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


@end
