//
//  PLEventsViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLEventsViewController.h"
#import <FBSDKCoreKit.h>
#import "PLEvent.h"
#import "PLEventTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@interface PLEventsViewController ()
@property (strong, nonatomic) NSMutableArray *events;
@end

@implementation PLEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"Events";
  
  
  __weak typeof(self) weakSelf = self;
  // For more complex open graph stories, use `FBSDKShareAPI`
  // with `FBSDKShareOpenGraphContent`
  /* make the API call */
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"/maxslifestyle/events"
                                parameters:@{@"fields":@"cover, name, place, start_time"}
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        NSDictionary * result,
                                        NSError *error) {
    NSLog(@"Events Results : %@", result);
    // Handle the result
    
    weakSelf.events = [NSMutableArray new];
    
    for (int i = 0; i < [result[@"data"] count]; i++) {
      NSLog(@"Data : %@", result[@"data"][i]);
      PLEvent *event = [PLEvent new];
      event.id = result[@"data"][i][@"id"];
      event.name = result[@"data"][i][@"name"];
      event.location = result[@"data"][i][@"place"][@"location"];
      event.imageUrl = result[@"data"][i][@"cover"][@"source"];
      event.start_time = result[@"data"][i][@"start_time"];
      [weakSelf.events addObject:event];
    }
    
    [weakSelf.tableView reloadData];
  }];
  
  [self.tableView registerClass:[PLEventTableViewCell class] forCellReuseIdentifier:@"PLEventTableViewCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"PLEventTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PLEventTableViewCell"];
  self.tableView.estimatedRowHeight = 400;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [self.events count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  PLEventTableViewCell *cell = (PLEventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PLEventTableViewCell" forIndexPath:indexPath];
  
  if (cell) {
    PLEvent * event = [self.events objectAtIndex:indexPath.row];
//    [cell clearLabels];
    [cell.nameLabel setText:event.name];
    [cell.locationLabel setText:event.location[@"city"]];
    [cell.dateLabel setText:event.start_time];
    [cell.eventCoverImageView setImageWithURL:[NSURL URLWithString:event.imageUrl] placeholderImage:[UIImage imageNamed:@"maxis_logo_large"]];
  }
  
  return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return UITableViewAutomaticDimension;
}

@end
