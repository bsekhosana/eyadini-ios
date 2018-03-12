//
//  PLEventTableViewCell.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/03/12.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLEventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *eventCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
