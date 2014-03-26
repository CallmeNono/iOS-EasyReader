//
//  CSMenuSearchFeedDataSource.m
//  EasyReader
//
//  Created by Michael Beattie on 3/20/14.
//  Copyright (c) 2014 Cloudspace. All rights reserved.
//

#import "CSMenuSearchFeedDataSource.h"

#import "UIColor+EZRSharedColorAdditions.h"

#import "CSSearchFeedCell.h"
#import "EZRCustomFeedCell.h"

@implementation CSMenuSearchFeedDataSource


/**
 * Sets each instance variable to the values in the given parameters
 */
- (id)init
{
    self = [super init];
    
    if (self) {
        _feeds = [[NSMutableSet alloc] init];
        _sortedFeeds = [[NSArray alloc] init];
    }
    
    return self;
}

/**
 * Sets the feeds to those returned by the search API or
 * The custom feed being created by the user
 *
 * @param feeds The NSSet of feeds to fill the menu with
 */
- (void)updateWithFeeds:(NSMutableSet *)feeds
{
    self.feeds = feeds;
    [self sortFeeds];
}

/**
 * Sort the feeds alphabetically
 */
- (void)sortFeeds
{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    self.sortedFeeds = [[NSArray arrayWithArray:[_feeds allObjects]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}


#pragma mark - Count Methods
/**
 * Determines the number of rows in each section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sortedFeeds count];
}


#pragma mark - Size Methods
/**
 * Height of the header in each section
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

/**
 * Height of all the cells
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


#pragma mark - Cell View
/**
 * Generates a cell for a given index path
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.sortedFeeds objectAtIndex:indexPath.row] objectForKey:@"feed_items"]) {
        // Dequeue a styled cell
        CSSearchFeedCell *cell = (CSSearchFeedCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchFeedCell"];
        
        // Get the feed
        NSDictionary *searchedFeedData = [self.sortedFeeds objectAtIndex:indexPath.row];
        
        // Set the cell data
        cell.feedData = searchedFeedData;
        [self setSelectedBackgroundForCell:cell];
        
        return cell;
    } else {
        // Dequeue a styled cell
        EZRCustomFeedCell *cell = (EZRCustomFeedCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomFeedCell"];
        
        // Get the feed
        NSDictionary *customFeedData = [self.sortedFeeds objectAtIndex:indexPath.row];

        // Set the cell data
        cell.feedData = customFeedData;
        [self setSelectedBackgroundForCell:cell];
        
        return cell;
    }
}

/**
 * Set the selectedBackgroundView for a cell
 *
 * @param cell The UITableViewCell to modify
 */
- (void)setSelectedBackgroundForCell:(UITableViewCell *)cell
{
    UIView *selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor: [UIColor EZR_charcoal]];
    cell.selectedBackgroundView = selectedBackgroundView;
}

@end
