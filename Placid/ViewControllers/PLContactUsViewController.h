//
//  PLContactUsViewController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLBaseViewController.h"
#import "AAShareBubbles.h"
#import <MessageUI/MessageUI.h>

@interface PLContactUsViewController : PLBaseViewController<AAShareBubblesDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *centerContactUsImageView;

@end
