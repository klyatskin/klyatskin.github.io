//
//  CEEvent.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "CEEvent.h"

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
    if (self == event)
        return false;
    Boolean result;
    result =  (self.start < event.end && event.start < self.end);
//    [self debugIsInConflictWith:event result:result];
    return result;
}


- (void)debugIsInConflictWith:(CEEvent *)event result:(Boolean)result {
    NSDateFormatter *formatter = [NSDateFormatter date2string];
    NSString *debugStr = [NSString stringWithFormat:@"[%@ - %@] ? [%@ - %@]",
                          [formatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: self.start]],
                          [formatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: self.end]],
                          [formatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: event.start]],
                          [formatter stringFromDate: [NSDate dateWithTimeIntervalSince1970: event.end]]
                          ];
    NSLog(@"%@ %@", result ? @"❌":@"✅", debugStr);
}



@end
