//
//  FeedCollectionViewDataSource.m
//  EasyReader
//
//  Created by Joseph Lorich on 3/13/14.
//  Copyright (c) 2014 Cloudspace. All rights reserved.
//

#import "EZRHomeCollectionViewDataSource.h"
#import "EZRHomeViewController.h"
#import "FeedItem.h"
#import "EZRFeedItemCell.h"

@implementation EZRHomeCollectionViewDataSource
{    
    /// The identifier to use to dequeue reusable cells for the collection view
    NSString *_reusableCellIdentifier;
    
    // A sorted array of feed items
    NSArray *_sortedFeedItems;
}

- (void)setFeedItems:(NSMutableSet *)feedItems
{
    _feedItems = feedItems;
    _sortedFeedItems = [self sortFeedItems:feedItems];
}

/**
 * Sets each instance variable to the values in the given parameters
 */
- (instancetype)initWithReusableCellIdentifier:(NSString *)reusableCellIdentifier {
    self = [super init];
    
    if (self)
    {
        _reusableCellIdentifier = reusableCellIdentifier;
    }
    
    return self;
}

/**
 * Sorts a set of feed items by the updatedAt time
 *
 * @params feedItems The set of feed items to sort
 */
- (NSArray *)sortFeedItems:(NSSet *)feedItems
{
    NSArray *sortableArray = [NSArray arrayWithArray:[self.feedItems allObjects]];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"updatedAt"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    return [sortableArray sortedArrayUsingDescriptors:sortDescriptors];
}

/**
 * Determines the number of sections in the collection view (in this case it's always 1)
 *
 * @param collectionView
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


/**
 * Determines the number of items in the current collectionView section
 *
 * @param collectionView
 * @param section
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_sortedFeedItems count];
}

/**
 * Dequeues and configures a UICollectionViewCell for the given index path
 *
 * @param collectionView
 * @param indexPath
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EZRFeedItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_reusableCellIdentifier
                                                                     forIndexPath:indexPath];
    
    cell.feedItem = [_sortedFeedItems objectAtIndex:indexPath.row];
    
//    [(CSHomeViewController*)collectionView.delegate setCollectionCellGoingTo:indexPath.row];
    
    return cell;
}

@end
