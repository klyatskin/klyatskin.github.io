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
    _start = [[dateFormatter dateFromString:start] timeIntervalSince1970];
    _end = [[dateFormatter dateFromString:end] timeIntervalSince1970];
    _collisionFlag = CEEventCollisionFlagUndefined;
    return self;
}

- (Boolean)isInConflictWith:(CEEvent *)event {
    // debug
    if (self == event)
        return false;
    NSDateFormatter *formatter = [NSDateFormatter date2string];
    NSString *debugStr = [NSString stringWithFormat:@"[%@ - %@] ? [%@ - %@]",
                       [formatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: self.start]],
                       [formatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: self.end]],
                       [formatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: event.start]],
                       [formatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: event.end]]
                          ];
    
    if (self.start < event.end && event.start < self.end) {
        NSLog(@"%@ ✅", debugStr);
        return true;
    }
    NSLog(@"%@ ❌", debugStr);
    return false;
}



@end
