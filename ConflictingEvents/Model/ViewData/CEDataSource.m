//
//  CEDataSource.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-07.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "DebugMacros.h"
#import "CEDataSource.h"
#import "CEDataProvider.h"
#import "CEBinaryTree.h"
#import "CEEventCell.h"


@interface CEDataSource () {
    NSMutableDictionary *_dataSource;
    NSArray *_sortedKeys;
    CEBinaryTree *_tree;
    CEBinaryTree *_treeBalanced;
}

@end


@implementation CEDataSource

#pragma mark - Singleton

+ (CEDataSource *)shared {
    
    static dispatch_once_t once;
    static CEDataSource* shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
        [shared loadAndPrepareData];
    });
    return shared;
}

#pragma mark - Data preparation


- (void) loadAndPrepareData {
    
    NSArray <CEEvent *> *events = [CEDataProvider events]; // load/parse data from Json
    
    _tree = [[CEBinaryTree alloc] init];  // create unbalance tree
    for (CEEvent *event in events)
        [_tree createNodeWithEvent:event];
    _treeBalanced = [_tree balancedOnSortedNodes];     // get balanced  tree + generate sorted array of nodes in unbalanced


#if DEBUG_FIXING_UNBALANCED
//    check tree visually...
//    NSLog(@"++++ Balanced - %@", [_tree isBalanced] ? @"YES":@"NO");
//    [_tree debugDumpInOrder];
//    NSLog(@"++++ Balanced - %@", [_treeBalanced isBalanced] ? @"YES":@"NO");
//    [_treeBalanced debugDumpInOrder];
    [_treeBalanced printNodeNamed:@"C"];
#endif
    
    // prepare data for UITableView
    _dataSource = [NSMutableDictionary dictionaryWithCapacity:1];
    NSDateFormatter *date2DayFormatter = [NSDateFormatter date2day];
    
    NSArray <CEBinaryNode*> *sortedNodes =  [_tree sortedNodes];
    for (CEBinaryNode* node in sortedNodes) {
        NSString * key = [date2DayFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970: node.event.start]];
        NSMutableArray *sections = _dataSource[key];
        if (sections) {
            [sections addObject:node.event];
        } else {
            NSMutableArray *events = [NSMutableArray arrayWithObject:node.event];
            [_dataSource setObject:events forKey:key];
        }
    }
    _sortedKeys = [[_dataSource allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark - Collisions search

- (void)colorCollisionForCell:(UITableViewCell *)cell andEvent:(CEEvent *)event  {
    // Use balanced tree as its perfomance is guaranted!
    CEEventCollisionFlag collisionFlag = [_treeBalanced collisionFlagForEvent:event];
    switch (collisionFlag) {
        case CEEventCollisionFlagUndefined:
            cell.contentView.backgroundColor = [UIColor whiteColor];
            break;
        case CEEventCollisionFlagCleared:
            cell.contentView.backgroundColor = [UIColor greenColor];
            break;
        case CEEventCollisionFlagCollided:
            cell.contentView.backgroundColor = [UIColor redColor];
            break;
        default:
            @throw [NSException exceptionWithName:@"event.collisionFlag"
                                           reason:@"event.collisionFlag inconsistent!"
                                         userInfo:nil];
    }
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CEEventCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];

    NSString *key = [_sortedKeys objectAtIndex:indexPath.section];
    CEEvent *event = _dataSource[key][indexPath.row];
    cell.lblTitle.text = event.title;
    // show times
    NSDateFormatter *date2StringFormatter = [NSDateFormatter date2string];
    cell.lblStart.text = [date2StringFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: event.start]];
    cell.lblEnd.text = [date2StringFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: event.end]];
    [self colorCollisionForCell:cell andEvent:event];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [_sortedKeys objectAtIndex:section];
    NSArray *events = _dataSource[key];
    return events.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sortedKeys.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_sortedKeys objectAtIndex:section];
}

@end
