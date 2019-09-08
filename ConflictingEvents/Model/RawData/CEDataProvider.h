//
//  CEDataProvider.h
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface CEDataProvider : NSObject

// threads are not supported could be improved e.g. changed to singleton
+ (NSArray <CEEvent *> *)events;

@end

NS_ASSUME_NONNULL_END
