//
//  NSArray+Shuffle.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-07.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)

- (NSArray *)shuffled { // Fisher–Yates shuffle
    NSMutableArray *shuffled = [self mutableCopy];
    for (NSUInteger i = self.count - 1; i > 0; i--) {
        NSUInteger j = arc4random_uniform((uint32_t)i + 1);
        [shuffled exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    return shuffled;
}

@end
