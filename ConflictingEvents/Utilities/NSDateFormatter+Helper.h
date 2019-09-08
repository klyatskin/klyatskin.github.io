//
//  NSDateFormatter+Helper.h
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (Helper)

+ (NSDateFormatter *)string2date;
+ (NSDateFormatter *)date2string;
+ (NSDateFormatter *)date2day;

@end

NS_ASSUME_NONNULL_END
