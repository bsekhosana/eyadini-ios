//
//  PLMainNavigationController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLMainNavigationController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "PLMainNavTableViewCell.h"
#import "PLConstants.h"
#import "UIImage+PLShadow.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface PLMainNavigationController ()
  @property (nonatomic, strong) NSArray *menuItems;
  @property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@end

// image reflection
static const CGFloat kDefaultReflectionFraction = 0.70;
static const CGFloat kDefaultReflectionOpacity = 0.30;

static NSString *CellIdentifier = @"PLMainNavTableViewCell";
@implementation PLMainNavigationController
  
- (void)viewDidLoad {
  [super viewDidLoad];
  
  // topViewController is the transitions navigation controller at this point.
  // It is initially set as a User Defined Runtime Attributes in storyboards.
  // We keep a reference to this instance so that we can go back to it without losing its state.
  self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
  
  [self.tableView registerClass:[PLMainNavTableViewCell class] forCellReuseIdentifier:CellIdentifier];
  
  [self.view setBackgroundColor:[PLConstants LOOKUP_COLOUR2]];
  [self.navLogoImageView setImage:[UIImage imageNamed:[PLConstants navLogoImageName]]];
  [self.navLogoImageView setContentMode:UIViewContentModeScaleAspectFit];
  
  // determine the size of the reflection to create
  int reflectionHeight = self.navLogoImageView.bounds.size.height * kDefaultReflectionFraction;
  
  // create the reflection image and assign it to the UIImageView
  self.reflectionView.image = [self reflectedImage:self.navLogoImageView withHeight:reflectionHeight];
  self.reflectionView.alpha = kDefaultReflectionOpacity;
  
  [self.logoutButton.titleLabel setFont:[PLConstants FONT_NAV_HEADING]];
  [self.logoutButton setTitleColor:[PLConstants LOOKUP_COLOUR1] forState:UIControlStateNormal];
  
}
  
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.view endEditing:YES];
}
   
- (IBAction)didTapLogoutButton:(id)sender {
   __weak typeof(self) weakSelf = self;
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [[GIDSignIn sharedInstance] signOut];
    NSString *domainName = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domainName];
    weakSelf.slidingViewController.topViewController = weakSelf.transitionsNavigationController;
    [weakSelf.slidingViewController resetTopViewAnimated:YES];
  }];
 
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    [weakSelf dismissViewControllerAnimated:alertController completion:nil];
  }];
  [alertController addAction:cancel];
  [alertController addAction:yes];
  [self presentViewController:alertController animated:YES completion:^{
    
  }];
  
}
#pragma mark - Properties
  
- (NSArray *)menuItems {
  if (_menuItems) return _menuItems;
  
  _menuItems = @[@"Home", @"About Us", @"Events", @"Gallery",@"My Profile", @"Social Networks", @"Contact Us"];
  
  return _menuItems;
}
  
#pragma mark - UITableViewDataSource
  
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.menuItems.count;
}
  
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PLMainNavTableViewCell *cell = [[PLMainNavTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  
  NSString *menuItem = self.menuItems[indexPath.row];
  
  cell.navTitleLabel.text = menuItem;
  [cell setBackgroundColor:[UIColor clearColor]];
  
  return cell;
}
  
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 55;
}
  
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
  NSString *menuItem = self.menuItems[selectedIndexPath.row];
  NSLog(@"%@", menuItem);
  // This undoes the Zoom Transition's scale because it affects the other transitions.
  // You normally wouldn't need to do anything like this, but we're changing transitions
  // dynamically so everything needs to start in a consistent state.
  self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
  

  if ([menuItem isEqualToString:@"Home"]) {
    self.slidingViewController.topViewController = self.transitionsNavigationController;
  }else{
      self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:[[NSString stringWithFormat:@"PL%@NavigationViewController", menuItem] stringByReplacingOccurrencesOfString:@" " withString:@""]];

  }
  
  [self.slidingViewController resetTopViewAnimated:YES];
}

#pragma mark - Image Reflection

CGImageRef CreateGradientImage(NSInteger pixelsWide, NSInteger pixelsHigh)
{
  CGImageRef theCGImage = NULL;
  
  // gradient is always black-white and the mask must be in the gray colorspace
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
  
  // create the bitmap context
  CGContextRef gradientBitmapContext = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh,
                                                             8, 0, colorSpace, kCGImageAlphaNone);
  
  // define the start and end grayscale values (with the alpha, even though
  // our bitmap context doesn't support alpha the gradient requires it)
  CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};
  
  // create the CGGradient and then release the gray color space
  CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
  CGColorSpaceRelease(colorSpace);
  
  // create the start and end points for the gradient vector (straight down)
  CGPoint gradientStartPoint = CGPointZero;
  CGPoint gradientEndPoint = CGPointMake(0, pixelsHigh);
  
  // draw the gradient into the gray bitmap context
  CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,
                              gradientEndPoint, kCGGradientDrawsAfterEndLocation);
  CGGradientRelease(grayScaleGradient);
  
  // convert the context into a CGImageRef and release the context
  theCGImage = CGBitmapContextCreateImage(gradientBitmapContext);
  CGContextRelease(gradientBitmapContext);
  
  // return the imageref containing the gradient
  return theCGImage;
}

CGContextRef MyCreateBitmapContext(NSInteger pixelsWide, NSInteger pixelsHigh)
{
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  
  // create the bitmap context
  CGContextRef bitmapContext = CGBitmapContextCreate (NULL, pixelsWide, pixelsHigh, 8,
                                                      0, colorSpace,
                                                      // this will give us an optimal BGRA format for the device:
                                                      (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
  CGColorSpaceRelease(colorSpace);
  
  return bitmapContext;
}

- (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSInteger)height
{
  if (height == 0)
    return nil;
  
  // create a bitmap graphics context the size of the image
  CGContextRef mainViewContentContext = MyCreateBitmapContext(fromImage.bounds.size.width, height);
  
  // create a 2 bit CGImage containing a gradient that will be used for masking the
  // main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
  // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
  CGImageRef gradientMaskImage = CreateGradientImage(1, height);
  
  // create an image by masking the bitmap of the mainView content with the gradient view
  // then release the  pre-masked content bitmap and the gradient bitmap
  CGContextClipToMask(mainViewContentContext, CGRectMake(0.0, 0.0, fromImage.bounds.size.width, height), gradientMaskImage);
  CGImageRelease(gradientMaskImage);
  
  // In order to grab the part of the image that we want to render, we move the context origin to the
  // height of the image that we want to capture, then we flip the context so that the image draws upside down.
  CGContextTranslateCTM(mainViewContentContext, 0.0, height);
  CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
  
  // draw the image into the bitmap context
  CGContextDrawImage(mainViewContentContext, fromImage.bounds, fromImage.image.CGImage);
  
  // create CGImageRef of the main view bitmap content, and then release that bitmap context
  CGImageRef reflectionImage = CGBitmapContextCreateImage(mainViewContentContext);
  CGContextRelease(mainViewContentContext);
  
  // convert the finished reflection image to a UIImage
  UIImage *theImage = [UIImage imageWithCGImage:reflectionImage];
  
  // image is retained by the property setting above, so we can release the original
  CGImageRelease(reflectionImage);
  
  return theImage;
}
  
  @end

