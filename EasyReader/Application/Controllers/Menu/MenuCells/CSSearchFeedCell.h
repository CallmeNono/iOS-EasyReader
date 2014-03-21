//
//  CSSearchFeedCell.h
//  EasyReader
//
//  Created by Michael Beattie on 3/20/14.
//  Copyright (c) 2014 Cloudspace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSEnhancedTableViewCell.h"
#import "Feed.h"

@interface CSSearchFeedCell : CSEnhancedTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView_icon;
@property (weak, nonatomic) IBOutlet UILabel *label_name;

#pragma mark - Other Properties

/// The feed item this cell is based on
@property (nonatomic, weak) Feed *feed;

@end