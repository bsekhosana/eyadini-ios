//
//  PLBaseViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLBaseViewController.h"
#import "PLDynamicTransition.h"
#import "UIViewController+ECSlidingViewController.h"
#import "PLDynamicTransition.h"
#import "PLTransitions.h"
#import "PLConstants.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface PLBaseViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, GADInterstitialDelegate>
@property (nonatomic, strong) PLTransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@end

@implementation PLBaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.transitions.dynamicTransition.slidingViewController = self.slidingViewController;
  
  // configure top view controller
  self.navigationController.navigationBar.barTintColor = [PLConstants COLOUR_BG_NAV_PRIMARY];
  self.navigationController.navigationBar.translucent = NO;
  self.navigationController.navigationBar.shadowImage = nil;
  
  [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                    NSFontAttributeName: [PLConstants FONT_NAV_HEADING],
                                                                    NSForegroundColorAttributeName : [PLConstants COLOUR_LBL_NAV_HEADING]}];
  
  UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:FA_ICON_BARS style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTapped:)];
  anchorRightButton.width = 44.0;
  [anchorRightButton setTitleTextAttributes:@{
                                          NSFontAttributeName: [PLConstants FONT_NAV_ICON],
                                          NSForegroundColorAttributeName: [PLConstants COLOUR_LBL_NAV_ACTION]
                                          } forState:UIControlStateNormal];
  [anchorRightButton setTitleTextAttributes:@{
                                              NSFontAttributeName: [PLConstants FONT_NAV_ICON],
                                              NSForegroundColorAttributeName: [PLConstants COLOUR_LBL_NAV_ACTION]
                                              } forState:UIControlStateSelected];
  [anchorRightButton setTintColor: [PLConstants COLOUR_BG_NAV_PRIMARY]];
  self.navigationItem.leftBarButtonItem  = anchorRightButton;
  
  UIBarButtonItem *anchorLeftButton = [[UIBarButtonItem alloc] initWithTitle:FA_ICON_CAMERA style:UIBarButtonItemStylePlain target:self action:@selector(takePhoto)];
  anchorLeftButton.width = 44.0;
  [anchorLeftButton setTitleTextAttributes:@{
                                              NSFontAttributeName: [PLConstants FONT_NAV_ICON],
                                              NSForegroundColorAttributeName: [PLConstants COLOUR_LBL_NAV_ACTION]
                                              } forState:UIControlStateNormal];
  [anchorLeftButton setTintColor: [PLConstants COLOUR_BG_NAV_PRIMARY]];
  self.navigationItem.rightBarButtonItem  = anchorLeftButton;
  
  NSDictionary *transitionData = @{ @"name" : @"Zoom",    @"transition" : self.transitions.zoomAnimationController };
  id<ECSlidingViewControllerDelegate> transition = transitionData[@"transition"];
  if (transition == (id)[NSNull null]) {
    self.slidingViewController.delegate = nil;
  } else {
    self.slidingViewController.delegate = transition;

    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    self.slidingViewController.customAnchoredGestures = @[];
    [self.navigationController.view removeGestureRecognizer:self.dynamicTransitionPanGesture];
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
  
  }
  
//  [[NSNotificationCenter defaultCenter] addObserver:self
//                                           selector:@selector(someMethod:)
//                                               name:UIApplicationDidBecomeActiveNotification object:nil];
  
  self.interstitialAd = [self createLoadInterstitial];
}


-(GADInterstitial *)createLoadInterstitial{
  GADRequest *request = [GADRequest new];
  GADInterstitial *interstitial = [[GADInterstitial alloc]initWithAdUnitID:@"ca-app-pub-3940256099942544~1458002511"];
  [interstitial setDelegate:self];
  request.testDevices = @[ kGADSimulatorID ];
  [interstitial loadRequest:request];
  
  return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
  self.interstitialAd = [self createLoadInterstitial];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
}

#pragma mark - take photo

-(void)takePhoto
{
//  if (self.interstitialAd.isReady) {
//    [self.interstitialAd presentFromRootViewController:self];
//  } else {
//    NSLog(@"Ad wasn't ready");
//  }
//
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];

  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
  {
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
  }

  // image picker needs a delegate,
  [imagePickerController setDelegate:self];

  // Place image picker on the screen
  [self presentViewController:imagePickerController animated:YES completion:nil];
}



-(void)chooseFromLibrary
{
  
  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
  [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  
  // image picker needs a delegate so we can respond to its messages
  [imagePickerController setDelegate:self];
  
  // Place image picker on the screen
  [self presentViewController:imagePickerController animated:YES completion:nil];
  
}

//delegate methode will be called after picking photo either from camera or library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  
  
  [self dismissViewControllerAnimated:YES completion:nil];
  UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
  [SVProgressHUD showWithStatus:@"Uploading"];
  [self uploadPhotoToFacebook:image];
}

-(void)uploadPhotoToFacebook:(UIImage *)image{
  // For more complex open graph stories, use `FBSDKShareAPI`
  // with `FBSDKShareOpenGraphContent`
  NSDictionary *params = @{
                           @"source":image,
                           @"message":@"#eyadini #iyadiLizokuMangaza #ios_eyadini_app"
                           };
  /* make the API call */
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"/eyadini/photos"
                                parameters:params
                                HTTPMethod:@"POST"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        id result,
                                        NSError *error) {
    [SVProgressHUD dismiss];
    
    // Handle the result
    NSLog(@"post image with error : %@", error.description);
    if (error) {
      [SVProgressHUD showErrorWithStatus:@"Facebook post failed, please try again later."];
    }else{
      [SVProgressHUD showSuccessWithStatus:@"Your photo has been posted to Eyadini Facebook posts feed."];
    }
  }];
}


-(void)showAlertWithTitle:(NSString *)title message:(NSString*)message{
  
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
}

#pragma mark - Properties
  
- (PLTransitions *)transitions {
  if (_transitions) return _transitions;
  
  _transitions = [[
                  PLTransitions alloc] init];
  
  return _transitions;
}
  
- (UIPanGestureRecognizer *)dynamicTransitionPanGesture {
  if (_dynamicTransitionPanGesture) return _dynamicTransitionPanGesture;
  
  _dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.transitions.dynamicTransition action:@selector(handlePanGesture:)];
  
  return _dynamicTransitionPanGesture;
}
  
  
- (IBAction)menuButtonTapped:(id)sender {
    if(self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight){
      [self.slidingViewController resetTopViewAnimated:YES];
    }else{
      [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
}
  
-(BOOL)prefersStatusBarHidden{
  return NO;
}

@end
