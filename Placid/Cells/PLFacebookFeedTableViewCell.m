//
//  PLFacebookFeedTableViewCell.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/15.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLFacebookFeedTableViewCell.h"

@implementation PLFacebookFeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)clearLabels{
  [self.createdTimeLabel setBackgroundColor:[UIColor clearColor]];
  [self.messageLabel setBackgroundColor:[UIColor clearColor]];
  [self.storyLabel setBackgroundColor:[UIColor clearColor]];
}

@end
