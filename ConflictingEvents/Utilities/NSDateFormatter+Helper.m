//
//  NSDateFormatter+Helper.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "NSDateFormatter+Helper.h"

@implementation NSDateFormatter (Helper)

// November 1, 2018 6:00 AM - used to parse
+ (NSDateFormatter *)string2date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy h:mm a"];
    return dateFormatter;
}


// Nov 1, 2018 at 6:00 AM - used for debug
+ (NSDateFormatter *)date2string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return dateFormatter;
}

// 2018/11/01 - used for table sections
+ (NSDateFormatter *)date2day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];


    return dateFormatter;
}

@end
