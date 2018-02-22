//
//  PLAboutUsViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLAboutUsViewController.h"
#import "PLConstants.h"

@interface PLAboutUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *poweredByLable;

@end

@implementation PLAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"About Us";
  
  [self.blobTextView setFont:[PLConstants FONT_MEDIUM_NORMAL_TEXT]];
  [self.blobTextView setTextColor:[PLConstants LOOKUP_COLOUR1]];
  
  [self.poweredByLable setTextColor:[PLConstants LOOKUP_COLOUR2]];
  [self.poweredByContainer setBackgroundColor:[PLConstants LOOKUP_COLOUR1]];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
