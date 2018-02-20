//
//  PLProfileTableViewCell.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/20.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLConstants.h"

@interface PLProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleCellLabel;
@property (weak, nonatomic) IBOutlet UIView *customDivider;

@end
