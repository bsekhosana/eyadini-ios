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
#import <FBSDKCoreKit.h>
#import "MWPhotoBrowser.h"

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface PLCHTCollectionViewController () <MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSArray *cellSizes;
@property (nonatomic, strong) NSMutableArray *photos;
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
    [cell.imageView setImageWithURL:[NSURL URLWithString:album.pictureUrl] placeholderImage:[UIImage imageNamed:@"eyadini_nav_logo"]];
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  PLFacebookAlbum *album = (PLFacebookAlbum*)[self.data objectAtIndex:indexPath.row];
  __weak typeof(self) weakSelf = self;
  [SVProgressHUD show];
  // For more complex open graph stories, use `FBSDKShareAPI`
  // with `FBSDKShareOpenGraphContent`
  /* make the API call */
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:[NSString stringWithFormat:@"/%@/photos", album.id]
                                parameters:@{@"fields":@"images,name,created_time,id", @"limit":@"100"}
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        NSDictionary * result,
                                        NSError *error) {
    // Handle the result
    weakSelf.photos = [NSMutableArray new];
    
    
    for (int i = 0; i < [result[@"data"] count]; i++) {
      NSLog(@"Data : %@", result[@"data"][i]);
      PLFacebookAlbum *album = [PLFacebookAlbum new];
      album.id = result[@"data"][i][@"id"];
      album.name = result[@"data"][i][@"name"];
      album.created_time = result[@"data"][i][@"created_time"];
      album.pictureUrl = result[@"data"][i][@"webp_images"][0][@"source"];
      
      MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:result[@"data"][i][@"images"][0][@"source"]]];
      photo.caption = result[@"data"][i][@"name"];
      [weakSelf.photos addObject:photo];
    }
    
    [weakSelf initializePhotoBrowserWithImages:[weakSelf.photos copy]];
  }];
  
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return [self.cellSizes[indexPath.item % 4] CGSizeValue];
}



#pragma mark - photo browser

-(void)initializePhotoBrowserWithImages:(NSArray *)images{
  
  // Create browser (must be done each time photo browser is
  // displayed. Photo browser objects cannot be re-used)
  MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
  
  // Set options
  browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
  browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
  browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
  browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
  browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
  browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
  browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
  browser.autoPlayOnAppear = NO; // Auto-play first video
  
  // Optionally set the current visible photo before displaying
  [browser setCurrentPhotoIndex:0];
  
  [SVProgressHUD dismiss];
  
  // Present
  [self.navController pushViewController:browser animated:YES];
  
  // Manipulate
  [browser showNextPhotoAnimated:YES];
  [browser showPreviousPhotoAnimated:YES];

}


- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
  return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
  if (index < self.photos.count) {
    return [self.photos objectAtIndex:index];
  }
  return nil;
}

@end
