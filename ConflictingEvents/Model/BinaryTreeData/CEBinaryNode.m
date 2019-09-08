//
//  CEBinaryNode.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "CEBinaryNode.h"

@implementation CEBinaryNode

- (instancetype)initWithEvent:(CEEvent *)event {
    self = [super init];
    self.event = event;
    self.maxEnd = event.end;
    return self;
}

- (instancetype)initWithNode:(CEBinaryNode *)node {
    self = [super init];
    self.event = node.event;
    self.maxEnd = node.event.end;
    return self;
}


@end
