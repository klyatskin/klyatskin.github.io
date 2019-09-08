//
//  CEDataProvider.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "DebugMacros.h"
#import "CEDataProvider.h"
#import "NSArray+Shuffle.h"

@interface CEDataProvider () {
}
@end


@implementation CEDataProvider

+ (NSArray <CEEvent *> *)events {

    static NSMutableArray <CEEvent *> *events; 
    if (events) return events;
    
    // read file
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"mock" ofType:@"json"];
    NSString* jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];

    NSError *err;
    NSArray *data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        return NULL;
    
    // populate model
    events = [NSMutableArray arrayWithCapacity:data.count];
    for (NSDictionary *dic in data) {
        CEEvent *event = [[CEEvent alloc] initWithTitle: dic[@"title"] start: dic[@"start"] end: dic[@"end"]];
        [events addObject:event];
    }
#if 0
    return [events shuffled];   // for random tests
#else
#if DEBUG_FIXING_UNBALANCED     // for debugging
    NSArray *halfArray;
    NSRange theRange;
    theRange.location = 0;
    theRange.length = 5;
    halfArray = [events subarrayWithRange:theRange];
    return halfArray;
#else
    return events;
#endif
#endif
}


@end
