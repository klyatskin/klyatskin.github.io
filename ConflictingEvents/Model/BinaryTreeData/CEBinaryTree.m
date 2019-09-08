//
//  CEBinaryTree.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "CEBinaryTree.h"
#import "CEBinaryNode.h"
#import "NSDateFormatter+Helper.h"

#define ABS64(x) ((x)<0 ? -(x) : (x))

// https://medium.com/@nbfuhao/leetcode-balanced-binary-tree-in-objective-c-6863ed058c5c // depth
// https://www.geeksforgeeks.org/interval-tree/

// https://www.geeksforgeeks.org/convert-normal-bst-balanced-bst/
// https://www.geeksforgeeks.org/sorted-array-to-balanced-bst/


@interface CEBinaryTree() {
}

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation CEBinaryTree {
    CEBinaryNode *_root;        // root node, or nil for an empty tree
    NSMutableArray <CEBinaryNode *> * _sortedNodes;
}

- (instancetype)init {
    self = [super init];
    self.dateFormatter = [NSDateFormatter date2string];
    return self;
}

#pragma mark - Unbalanced:
// memory O(N)
// search/insert O(log N), O(N) at worst

- (CEBinaryNode *)createNodeWithEvent:(CEEvent *)event {
    _root = [self insertNode:_root withEvent:event];
    return _root;
}


- (CEBinaryNode *)insertNode:(CEBinaryNode *)node withEvent:(CEEvent *)event{
    if (node == nil) {
        return [[CEBinaryNode alloc] initWithEvent:event];
    }
    if (event.start < node.event.start)
        node.left = [self insertNode:node.left withEvent:event];
    else
        node.right = [self insertNode:node.right withEvent:event];
    if (node.maxEnd < event.end)
        node.maxEnd = event.end;
    return node;
}

#pragma mark - Balanced
// memory O(N)
// search/insert O(log N)

- (NSUInteger)maxDepthForNode:(CEBinaryNode *)node {
    if (node == nil) return 0;
    return MAX([self maxDepthForNode:node.left], [self maxDepthForNode:node.right]) + 1;
}


- (Boolean)isBalanced:(CEBinaryNode *)node {
    if (!node) return true;
    NSInteger dLeft = [self maxDepthForNode:node.left];
    NSInteger dRight = [self maxDepthForNode:node.right];
    Boolean b1 = ABS64(dLeft - dRight) <= 1;
    Boolean b2 = [self isBalanced:node.left];
    Boolean b3 = [self isBalanced:node.right];
    return (b1 && b2 && b3);
}


- (Boolean)isBalanced {
    return [self isBalanced:_root];
}

- (void)pushNode:(CEBinaryNode*)node toSortedArray:(NSMutableArray <CEBinaryNode *> * )allNodes {
    if (node == NULL) return;
    [self pushNode:node.left toSortedArray:allNodes];
    [allNodes addObject:node];
    [self pushNode:node.right toSortedArray:allNodes];
}


- (CEBinaryNode *)insertNodesArray:(NSArray <CEBinaryNode*> *)arr start:(NSInteger)start end:(NSInteger)end {
    if (start > end)
        return NULL;
    NSInteger mid = (start + end)/2;
    CEBinaryNode *root = [[CEBinaryNode alloc] initWithNode:arr[mid]];
    root.left =  [self insertNodesArray:arr start:start end:mid-1];
    root.right = [self insertNodesArray:arr start:mid+1 end:end];
    return root;
}


- (CEBinaryTree *)balancedOnSortedNodes {
    CEBinaryTree *balancedTree = [[CEBinaryTree alloc] init];
    // populate sorted array of nodes
    _sortedNodes = [NSMutableArray new];
    [self pushNode:_root toSortedArray:_sortedNodes];
    balancedTree->_root = [balancedTree insertNodesArray:_sortedNodes start:0 end:_sortedNodes.count-1];
    return balancedTree;
}


- (NSArray <CEBinaryNode *> *)sortedNodes {
    return  _sortedNodes;
}

#pragma mark - CollisionCheck

// return a event for a first collision or null
- (CEEvent *)foundCollisionFromNode:(CEBinaryNode *)root forEvent:(CEEvent*)event {
    if (root == NULL) return NULL;
    if ([event isInConflictWith:root.event])
        return root.event;
    if (root.left != NULL && (root.left.maxEnd >= event.start))
        return [self foundCollisionFromNode:root.left forEvent:event];
    return [self foundCollisionFromNode:root.right forEvent:event];
}

- (CEEventCollisionFlag)collisionFlagForEvent:(CEEvent *)event {
    if (event.collisionFlag != CEEventCollisionFlagUndefined) // some caching approach
        return event.collisionFlag;
    if ([self foundCollisionFromNode:_root forEvent:event])
        return CEEventCollisionFlagCollided;
    return CEEventCollisionFlagCleared;
}



#pragma mark - Debug helpers

- (void)debugDumpInOrder {
    [self debugDumpInOrder: _root];
}

- (void)debugDumpPreOrder {
    [self debugDumpPreOrder: _root];
}

- (void)debugDumpInOrder:(CEBinaryNode *)node {
    if (node == NULL) return;
    [self debugDumpInOrder:node.left];
    NSLog(@"%@ [%@ - %@], max = %@", node.event.title,
          [self.dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: node.event.start]],
          [self.dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: node.event.end]],
          [self.dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: node.maxEnd]]);
    [self debugDumpInOrder:node.right];
}

- (void)debugDumpPreOrder:(CEBinaryNode *)node {
    if (node == NULL) return;
    NSLog(@"%@ [%@ - %@], max = %@", node.event.title,
          [self.dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: node.event.start]],
          [self.dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: node.event.end]],
          [self.dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: node.maxEnd]]);
    [self debugDumpPreOrder:node.left];
    [self debugDumpPreOrder:node.right];
}

@end
