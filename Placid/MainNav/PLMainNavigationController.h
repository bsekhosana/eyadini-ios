//
//  PLMainNavigationController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLMainNavigationController :  UIViewController <UITableViewDataSource, UITableViewDelegate>
  @property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
