//
//  PLProfileTableViewCell.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/20.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLProfileTableViewCell.h"

@implementation PLProfileTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PLProfileTableViewCell" owner:self options:nil];
    self = [nib objectAtIndex:0];
  }
  
  return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
  [self.customDivider setBackgroundColor:[PLConstants LOOKUP_COLOUR1]];
  [self.titleCellLabel setFont:[PLConstants FONT_NAV_HEADING]];
  [self.titleCellLabel setTextColor:[PLConstants LOOKUP_COLOUR1]];
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
