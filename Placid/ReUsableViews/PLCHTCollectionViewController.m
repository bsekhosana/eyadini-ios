//
//  PLCHTCollectionViewController.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/03/09.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLCHTCollectionViewController.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "PLFacebookAlbum.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface PLCHTCollectionViewController ()
@property (nonatomic, strong) NSArray *cellSizes;
@end

@implementation PLCHTCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
  self = [super initWithCollectionViewLayout:layout];
  
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
  self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.collectionView.backgroundColor = [UIColor whiteColor];
  [self.collectionView registerClass:[CHTCollectionViewWaterfallCell class]
          forCellWithReuseIdentifier:CELL_IDENTIFIER];
  [self.collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
          forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                 withReuseIdentifier:HEADER_IDENTIFIER];
  [self.collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
          forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                 withReuseIdentifier:FOOTER_IDENTIFIER];
  
  if (!_cellSizes) {
    _cellSizes = @[
                   [NSValue valueWithCGSize:CGSizeMake(550, 550)],
                   [NSValue valueWithCGSize:CGSizeMake(1000, 765)],
                   [NSValue valueWithCGSize:CGSizeMake(1024, 989)],
                   [NSValue valueWithCGSize:CGSizeMake(640, 427)]
                   ];
  }
  
  return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)configureCollectionViewLayout{
  if (!self.collectionView) {
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerHeight = 15;
    layout.footerHeight = 10;
    layout.minimumColumnSpacing = 20;
    layout.minimumInteritemSpacing = 30;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CHTCollectionViewWaterfallCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [self.collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:HEADER_IDENTIFIER];
    [self.collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
               withReuseIdentifier:FOOTER_IDENTIFIER];
  }
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [self.data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CHTCollectionViewWaterfallCell *cell =
  (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                              forIndexPath:indexPath];
  
  if (self.albumType == FacebookAlbum) {
    PLFacebookAlbum *album = [self.data objectAtIndex:indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:album.pictureUrl] placeholderImage:[UIImage imageNamed:@"maxis_logo_large"]];
    cell.name.text = album.name;
    cell.date.text = album.created_time;
  }
  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  UICollectionReusableView *reusableView = nil;
  
  if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                      withReuseIdentifier:HEADER_IDENTIFIER
                                                             forIndexPath:indexPath];
  } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                      withReuseIdentifier:FOOTER_IDENTIFIER
                                                             forIndexPath:indexPath];
  }
  
  [reusableView setBackgroundColor:[UIColor clearColor]];
  
  return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return [self.cellSizes[indexPath.item % 4] CGSizeValue];
}

@end
