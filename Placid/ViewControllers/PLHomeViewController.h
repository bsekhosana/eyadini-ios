//
//  PLHomeViewController.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLBaseViewController.h"
#import <iCarousel/iCarousel.h>

@interface PLHomeViewController : PLBaseViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *carouselContainer;
@property (weak, nonatomic) IBOutlet UIView *carouselDividerView;
@property (weak, nonatomic) IBOutlet UIView *latestNewsContainerView;
@property (weak, nonatomic) IBOutlet UILabel *latestNewsLable;
@property (weak, nonatomic) IBOutlet UILabel *upComingEventsLabel;

@property (weak, nonatomic) IBOutlet UIView *upCommingEventsCOntainerView;
@end
