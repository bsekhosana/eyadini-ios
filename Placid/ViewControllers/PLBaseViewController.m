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
#import <CoreLocation/CoreLocation.h>
#import <FBSDKGraphRequest.h>
@import GoogleMobileAds;
#import "AppDelegate.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface PLBaseViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, GADInterstitialDelegate, CLLocationManagerDelegate, GADBannerViewDelegate>
@property (nonatomic, strong) PLTransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@property (nonatomic, strong)  CLLocationManager *locationManager;
@property (nonatomic, strong)  CLGeocoder *geocoder;
@property (strong, nonatomic) CLLocation *currentLocation;
@property(nonatomic, strong) GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property BOOL isHomeScreen;
@end

@implementation PLBaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.transitions.dynamicTransition.slidingViewController = self.slidingViewController;
  self.slidingViewController.panGesture.enabled = YES;
  AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
  
  self.interstitial = appDel.interstitial;
  self.interstitial.delegate = self;
  
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
  
  
  UIBarButtonItem *anchorLeftButton1 = [[UIBarButtonItem alloc] initWithTitle:FA_ICON_MAP_MARKER style:UIBarButtonItemStylePlain target:self action:@selector(checkIn)];
  anchorLeftButton1.width = 44.0;
  [anchorLeftButton1 setTitleTextAttributes:@{
                                             NSFontAttributeName: [PLConstants FONT_NAV_ICON],
                                             NSForegroundColorAttributeName: [PLConstants COLOUR_LBL_NAV_ACTION]
                                             } forState:UIControlStateNormal];
  [anchorLeftButton1 setTintColor: [PLConstants COLOUR_BG_NAV_PRIMARY]];
  
  self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:anchorLeftButton1,anchorLeftButton, nil];
  
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
}


- (void)addBannerViewToView:(UIView *)bannerView {
  bannerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:bannerView];
  if (@available(ios 11.0, *)) {
    // In iOS 11, we need to constrain the view to the safe area.
    [self positionBannerViewFullWidthAtBottomOfSafeArea:self.bannerView];
  } else {
    // In lower iOS versions, safe area is not available so we use
    // bottom layout guide and view edges.
    [self positionBannerViewFullWidthAtBottomOfView:self.bannerView];
  }
}


-(void)setIsHomeScreen{
  self.isHomeScreen = YES;
}
#pragma mark - view positioning

- (void)positionBannerViewFullWidthAtBottomOfSafeArea:(UIView *_Nonnull)bannerView NS_AVAILABLE_IOS(11.0) {
  // Position the banner. Stick it to the bottom of the Safe Area.
  // Make it constrained to the edges of the safe area.
  UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
  
  [NSLayoutConstraint activateConstraints:@[
                                            [guide.leftAnchor constraintEqualToAnchor:bannerView.leftAnchor],
                                            [guide.rightAnchor constraintEqualToAnchor:bannerView.rightAnchor],
                                            [guide.bottomAnchor constraintEqualToAnchor:bannerView.bottomAnchor]
                                            ]];
}

- (void)positionBannerViewFullWidthAtBottomOfView:(UIView *_Nonnull)bannerView {
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1
                                                         constant:0]];
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1
                                                         constant:0]];
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.bottomLayoutGuide
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1
                                                         constant:0]];
}


-(void)checkIn{
    if ([FBSDKAccessToken currentAccessToken]) {
      NSLog(@"Token : %@", [FBSDKAccessToken currentAccessToken]);
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Facebook Checkin" message:@"Do you want to check in @ Eyadini?." preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *action = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:nil];
      UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showWithStatus:@"Checking In To Eyadini Lounge"];
        // For more complex open graph stories, use `FBSDKShareAPI`
        // with `FBSDKShareOpenGraphContent`
        /* make the API call */
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"/EyadiniLoungenuz?fields=location"
                                      parameters:nil
                                      HTTPMethod:@"GET"];
        
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result,
                                              NSError *error) {
          // Handle the result
          NSLog(@"Location : %@", result);
          
          NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys: @"#eyadini_ios_app", @"message", result[@"id"], @"place", nil];
          
          FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                        initWithGraphPath:@"me/feed"
                                        parameters:params
                                        HTTPMethod:@"POST"];
          [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                id result,
                                                NSError *error) {
            // Handle the result
            NSLog(@"Location Post Result : %@", result);
            [SVProgressHUD showSuccessWithStatus:@"Your have successfully checked into Eyadini Lounge."];
          }];
          
        }];
      }];
      [alert addAction:action];
      [alert addAction:actionOk];
      
      [self.navigationController presentViewController:alert animated:YES completion:nil];
    }else{
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Facebook Login" message:@"Please login to your facebook account in order for you to checkin @ Eyadini." preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __weak typeof(self) weakSelf = self;
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logInWithReadPermissions:@[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
          //TODO: process error or result.
          if (error) {
            NSLog(@"Process error");
            [self facebookLoginFailed:YES];
          } else if (result.isCancelled) {
            [self facebookLoginFailed:NO];
          } else {
            if ([FBSDKAccessToken currentAccessToken]) {
              NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
              [weakSelf checkIn];
            }
            else {
              [self facebookLoginFailed:YES];
            }
          }
        }];
      }];
      [alert addAction:actionOk];
      
      [self.navigationController presentViewController:alert animated:YES completion:nil];
      
    }
}

- (void)facebookLoginFailed:(BOOL)isFBResponce{
  if(isFBResponce){
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"The request had an error, please try again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:actionOk];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
  }
  else{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Error" message:@"Credentials do not match, please try again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:actionOk];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
  }
}

- (GADInterstitial *)createAndLoadInterstitial {
  GADInterstitial *interstitial =
  [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4729924057203075/1999491582"];
  [interstitial loadRequest:[GADRequest request]];
  return interstitial;
}


-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
}

#pragma mark - take photo

-(void)takePhoto
{
  if ([FBSDKAccessToken currentAccessToken]) {
    NSLog(@"Token : %@", [FBSDKAccessToken currentAccessToken]);
    if ([CLLocationManager locationServicesEnabled]) {
      self.locationManager = [[CLLocationManager alloc] init];
      self.locationManager.delegate = self;
      
      if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
      {
        [self.locationManager requestWhenInUseAuthorization];
      }else{
        [self.locationManager requestAlwaysAuthorization];
      }
      
      [self.locationManager startUpdatingLocation];
    } else {
      NSLog(@"Location services are not enabled");
      
      [self erroWithLocationService];
    }
    
  }else{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Facebook Login" message:@"Please login to your facebook account in order for you to take a selfie." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      __weak typeof(self) weakSelf = self;
      FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
      [loginManager logInWithPublishPermissions:@[@"publish_actions"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        //TODO: process error or result.
        if (error) {
          NSLog(@"Process error");
          [self facebookLoginFailed:YES];
        } else if (result.isCancelled) {
          [self facebookLoginFailed:NO];
        } else {
          if ([FBSDKAccessToken currentAccessToken]) {
            NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
            [weakSelf takePhoto];
          }
          else {
            [self facebookLoginFailed:YES];
          }
        }
      }];
    }];
    [alert addAction:actionOk];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
  }
}

-(void)erroWithLocationService{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Location Service" message:@"Please enable your location service on your device settings before you continue with this action." preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
  [alert addAction:action];
  
  [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  self.currentLocation = [locations lastObject];
  
  CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:-29.956644 longitude:30.921089];
  
  CLLocationDistance distance = [[locations lastObject] distanceFromLocation:centerLocation];
  
  CLLocationDistance kilometers = distance / 1000.0;
  
  NSLog(@"%f",kilometers);
  
  if (kilometers > 0 && kilometers < 0.1) {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
      [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    // image picker needs a delegate,
    [imagePickerController setDelegate:self];
    
    // Place image picker on the screen
    [self presentViewController:imagePickerController animated:YES completion:nil];
  }else{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Not Within Bounds" message:@"You have to be within atleast 100 meters of Eyadini Lounge to take a selfie." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
  }
  
  [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  NSLog(@"failed to fetch current location : %@", error);
  [self erroWithLocationService];
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
                                initWithGraphPath:@"/EyadiniLoungenuz/photos"
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
  
  if (self.isHomeScreen) {
    if (self.interstitial.isReady) {
      [self.interstitial presentFromRootViewController:self];
    }
  }else{
    // In this case, we instantiate the banner with desired ad size.
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:kGADAdSizeSmartBannerPortrait];
    
    
    self.bannerView.adUnitID = @"ca-app-pub-4729924057203075/7073808579";
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[ @"88d259d71435f65e7765d4e0264b39c9" ];
    [self.bannerView loadRequest:request];
  }
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

#pragma mark - interstitial ad delegate

/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
  NSLog(@"interstitialDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
  NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
  NSLog(@"interstitialWillDismissScreen");
}

/// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
  NSLog(@"interstitialDidDismissScreen");
  self.interstitial = [self createAndLoadInterstitial];
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
  NSLog(@"interstitialWillLeaveApplication");
}





#pragma mark - banner ad delegate

/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
  NSLog(@"adViewDidReceiveAd");
  [self addBannerViewToView:self.bannerView];
  
  adView.alpha = 0;
  [UIView animateWithDuration:1.0 animations:^{
    adView.alpha = 1;
  }];
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
  NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
  NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
  NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
  NSLog(@"adViewWillLeaveApplication");
}


@end
