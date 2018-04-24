//
//  PLInstagramTableViewCell.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/04/24.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLInstagramTableViewCell.h"

@implementation PLInstagramTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
