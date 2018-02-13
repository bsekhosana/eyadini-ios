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

@interface PLBaseViewController ()
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
