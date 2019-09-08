//
//  CEDataSource.h
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-07.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEDataSource : NSObject <UITableViewDataSource>

+ (CEDataSource *)shared;

@end

NS_ASSUME_NONNULL_END
