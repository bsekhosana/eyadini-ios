//
//  PLFacebookFeedTableViewCell.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/15.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLFacebookFeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *facebookPlaceholderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UILabel *createdTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storyLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

-(void)clearLabels;

@end
