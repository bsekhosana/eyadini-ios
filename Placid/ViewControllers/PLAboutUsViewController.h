//
//  PLAboutUsViewController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLBaseViewController.h"

@interface PLAboutUsViewController : PLBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITextView *blobTextView;
@property (weak, nonatomic) IBOutlet UIView *poweredByContainer;
@property (weak, nonatomic) IBOutlet UIImageView *waterMarkImageView;

@end
