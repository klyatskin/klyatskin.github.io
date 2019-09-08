//
//  CEEventCell.h
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-07.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * kCellID = @"CEEventCellID";

@interface CEEventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblStart;
@property (weak, nonatomic) IBOutlet UILabel *lblEnd;

@end

NS_ASSUME_NONNULL_END
