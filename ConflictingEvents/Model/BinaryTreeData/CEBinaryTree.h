//
//  CEBinaryTree.h
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEEvent.h"
#import "CEBinaryNode.h"

NS_ASSUME_NONNULL_BEGIN

//TODO: refactor tree/nodes to some base class

@interface CEBinaryTree : NSObject

- (CEBinaryNode *)createNodeWithEvent:(CEEvent *)event; // unbalanced...
- (Boolean)isBalanced;
- (CEBinaryTree *)balancedOnSortedNodes;

- (NSArray <CEBinaryNode *> *)sortedNodes; // NULL if no balanced was requested...
- (CEEventCollisionFlag)collisionFlagForEvent:(CEEvent *)event;

// debug
- (void)debugDumpInOrder;
- (void)debugDumpPreOrder;
- (void)printNodeNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
