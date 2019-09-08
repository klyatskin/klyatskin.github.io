//
//  CEDataProvider.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

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
    
//    return [events shuffled]; // for testing
    
/**** for easier debug only...
    NSArray *halfArray;
    NSRange theRange;
    theRange.location = 0;
    theRange.length = 4;
    halfArray = [events subarrayWithRange:theRange];
    return halfArray;
*****/
    
    return events;
}


@end
