//
//  CEBinaryNode.h
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface CEBinaryNode : NSObject

@property (nonatomic) CEBinaryNode *left;
@property (nonatomic) CEBinaryNode *right;
@property (nonatomic, weak) CEEvent *event;
@property (nonatomic) NSTimeInterval maxEnd;

- (instancetype)initWithEvent:(CEEvent *)event;
- (instancetype)initWithNode:(CEBinaryNode *)node;


@end

NS_ASSUME_NONNULL_END
