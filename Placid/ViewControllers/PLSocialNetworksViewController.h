//
//  PLSocialNetworksViewController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/14.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLBaseViewController.h"

@interface PLSocialNetworksViewController : PLBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *topViewNav;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *instagramButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIView *bottomDividerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDividerLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *twitterContainer;
@property (weak, nonatomic) IBOutlet UIView *instagramContainer;
@property (weak, nonatomic) IBOutlet UIView *facebookContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookCOntainerLeadingConstraint;
@property (weak, nonatomic) IBOutlet UITableView *facebookTableView;

@end
