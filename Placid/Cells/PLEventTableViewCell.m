//
//  PLEventTableViewCell.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/03/12.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLEventTableViewCell.h"

@implementation PLEventTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PLEventTableViewCell" owner:self options:nil];
    self = [nib objectAtIndex:0];
  }
  
  return self;
}

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
