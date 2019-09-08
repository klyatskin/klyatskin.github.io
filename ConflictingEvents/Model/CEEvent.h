//
//  CEEvent.h
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDateFormatter+Helper.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CEEventCollisionFlag) {
    CEEventCollisionFlagUndefined,
    CEEventCollisionFlagCleared,
    CEEventCollisionFlagCollided
};

@interface CEEvent : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSDate *start;
@property (nonatomic, readonly) NSDate *end;
@property (nonatomic, readonly) CEEventCollisionFlag collisionFlag;


- (instancetype)initWithTitle:(NSString *)title start:(NSString *)start end:(NSString *)end;
- (Boolean)isInConflictWith:(CEEvent *)event;

@end

NS_ASSUME_NONNULL_END
