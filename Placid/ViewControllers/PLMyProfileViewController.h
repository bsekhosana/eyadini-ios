//
//  PLMyProfileViewController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/14.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLBaseViewController.h"
#import <MXParallaxHeader/MXScrollView.h>
#import <MXParallaxHeader/MXParallaxHeader.h>

@interface PLMyProfileViewController : PLBaseViewController <MXParallaxHeaderDelegate>
@property (weak, nonatomic) IBOutlet MXScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
