//
//  CEEvent.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "CEEvent.h"


@interface CEEvent () {
}

@end

@implementation CEEvent

- (instancetype)initWithTitle:(NSString *)title start:(NSString *)start end:(NSString *)end {
    self = [super init];
    _title = title;
    NSDateFormatter *dateFormatter = [NSDateFormatter string2date];
    _start = [dateFormatter dateFromString:start];
    _end = [dateFormatter dateFromString:end];
    _collisionFlag = CEEventCollisionFlagUndefined;
    return self;
}

- (Boolean)isInConflictWith:(CEEvent *)event {
    // debug
    if (self == event)
        return false;
    NSDateFormatter *formatter = [NSDateFormatter date2string];
    NSString *debugStr = [NSString stringWithFormat:@"[%@ - %@] ? [%@ - %@]",
                       [formatter stringFromDate:self.start],
                       [formatter stringFromDate:self.end],
                       [formatter stringFromDate:event.start],
                       [formatter stringFromDate:event.end]];
    
    if ([self.end compare:event.start] == NSOrderedAscending) {
        NSLog(@"%@ ✅", debugStr);
        return false;
    }
    if ([self.end compare:event.start] == NSOrderedSame) {
        NSLog(@"%@ ✅", debugStr);
        return false;
    }
    if ([self.start compare:event.end] == NSOrderedDescending) {
        NSLog(@"%@ ✅", debugStr);
        return false;
    }
    if ([self.start compare:event.end] == NSOrderedSame) {
        NSLog(@"%@ ✅", debugStr);
        return false;
    }
    NSLog(@"%@ ❌", debugStr);
    return true;
}



@end
