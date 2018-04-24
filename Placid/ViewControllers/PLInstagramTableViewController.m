//
//  PLInstagramTableViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/04/23.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLInstagramTableViewController.h"

#import "UploadedOn.h"
#import "TotalLikes_Comments.h"
#import "SuggestedPeopleCell.h"
#import "PostImage.h"
#import "PostDescription.h"
#import "DetailText.h"
#import "Buttons.h"
#import "SectionHeaderOfPost.h"
#import "PLInstagramFeed.h"
#import <AFNetworking/AFNetworking.h>
#import "PLInstagramTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "NSDate+TimeAgo.h"

@interface PLInstagramTableViewController ()
@property (nonatomic, strong) NSMutableArray * feedDataArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@property (nonatomic, strong) NSMutableArray * commentsArray;
@property (nonatomic, strong) NSMutableArray * imagesArray;
@property (nonatomic, strong) NSMutableArray * captionsArray;
@property (nonatomic, strong) NSMutableArray * numberOfLikesArray;
@end

@implementation PLInstagramTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
  [self registerCells];
  
  AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
  self.feedDataArray=[NSMutableArray new];
  

  __weak typeof(self) weakSelf = self;
  [manager GET:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=521058849.1677ed0.e2f9d96391c040d784bd5b1938eadc9f" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    for (int i = 0; i < [responseObject[@"data"] count]; i++) {
      NSLog(@"Data : %@", responseObject[@"data"][i]);
      if ([responseObject[@"data"][i][@"type"] isEqualToString:@"image"]) {
        PLInstagramFeed *feed = [PLInstagramFeed new];
        feed.comments = responseObject[@"data"][i][@"comments"];
        feed.images = responseObject[@"data"][i][@"images"];
        feed.caption = responseObject[@"data"][i][@"caption"];
        feed.likes = responseObject[@"data"][i][@"likes"];
        [weakSelf.feedDataArray addObject:feed];
      }
      [weakSelf.tableView reloadData];
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"Error: %@", error);
  }];
  
  
  self.tableView.estimatedRowHeight=10;
  self.tableView.rowHeight=UITableViewAutomaticDimension;
  
}

-(void)registerCells{
  
  UINib *nib = [UINib nibWithNibName:@"PLInstagramTableViewCell" bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"PLInstagramTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark === Tableview DataSources=======
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return self.feedDataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  PLInstagramTableViewCell *cell = (PLInstagramTableViewCell *)[aTableView dequeueReusableCellWithIdentifier:@"PLInstagramTableViewCell" forIndexPath:indexPath];
  
  if (cell) {
    PLInstagramFeed * feed = [self.feedDataArray objectAtIndex:indexPath.row];
    NSTimeInterval epoch = [feed.caption[@"created_time"] doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:epoch];
    [cell.dateTimeLabel setText:[date timeAgo]];
    [cell.captionLabel setText:feed.caption[@"text"]];
    [cell.numberOfLikesLabel setText:[NSString stringWithFormat:@"%@ Likes", feed.likes[@"count"]]];
    [cell.numberOfCommentsLabel setText:[NSString stringWithFormat:@"%@ Comments", feed.comments[@"count"]]];
    [cell.postImageView setImageWithURL:[NSURL URLWithString:feed.images[@"standard_resolution"][@"url"]] placeholderImage:[UIImage imageNamed:@"eyadini_nav_logo"]];
  }

  return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return UITableViewAutomaticDimension;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 15;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  SuggestedPeopleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
  //cell.titleLabel.text=@"Name";
  // cell.subTitleLabel.text = @"Detail Text";
  cell.layer.cornerRadius=4;
  cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
  cell.layer.borderWidth=0.5;
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(140, 150);
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (![scrollView isKindOfClass:[UICollectionView class]]) return;
  
  CGFloat horizontalOffset = scrollView.contentOffset.x;
  
  UICollectionView *collectionView = (UICollectionView *)scrollView;
  NSInteger index = collectionView.tag;
  self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}



@end
