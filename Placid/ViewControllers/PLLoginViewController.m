//
//  PLLoginViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/20.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLLoginViewController.h"
#import "PLConstants.h"
#import "PLUser.h"

@interface PLLoginViewController ()

@end

@implementation PLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//  UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
//  UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blur];
//  blurView.frame = self.backgroundImageView.frame;
//  [self.backgroundImageView addSubview:blurView];
  [self.navigationController.navigationBar setHidden:YES];
  self.facebookLoginButton.readPermissions = @[@"public_profile", @"email"];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLogIn) name: FBSDKAccessTokenDidChangeNotification object:nil];
  [self.orLabel setFont:[PLConstants FONT_NAV_HEADING]];
  [self.orLabel setTextColor:[PLConstants LOOKUP_COLOUR2]];
  [GIDSignIn sharedInstance].uiDelegate = self;
  [GIDSignIn sharedInstance].delegate = self;
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

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
}

-(void)checkLogIn{
  NSLog(@"Facebook Token Shyt: %@", [FBSDKAccessToken currentAccessToken]);
  if ([FBSDKAccessToken currentAccessToken]) {
    
    
    [self userLoggedIn];
  }
}


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
  
  PLUser *currentUser = [PLUser new];
  currentUser.id = user.userID;
  currentUser.username = user.profile.givenName;
  currentUser.name = user.profile.name;
  currentUser.email = user.profile.email;
//  currentUser.contactNumber = user.c
  NSError *errorJson;
  PLUser *newUser = [[PLUser alloc]initWithDictionary:[currentUser toDictionary] error:&errorJson];
  NSLog(@"Current User : %@", newUser);
  [self userLoggedIn];
}

-(void)userLoggedIn{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [self.facebookLoginButton setHidden:YES];
  // User is logged in, do work such as go to next view controller.
  [self.navigationController.navigationBar setHidden:NO];
  [self.navigationController popViewControllerAnimated:YES];
  
  [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:@"loggedIn"];
}

@end
