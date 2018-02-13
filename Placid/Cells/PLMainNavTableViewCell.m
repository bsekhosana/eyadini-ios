//
//  PLMainNavTableViewCell.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLMainNavTableViewCell.h"
#import "PLConstants.h"

@implementation PLMainNavTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PLMainNavTableViewCell" owner:self options:nil];
    self = [nib objectAtIndex:0];
  }
  
  return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
  [self.bottomDivider setBackgroundColor:[PLConstants LOOKUP_COLOUR1]];
  [self.navTitleLabel setFont:[PLConstants FONT_NAV_HEADING]];
  [self.navTitleLabel setTextColor:[PLConstants LOOKUP_COLOUR1]];
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
