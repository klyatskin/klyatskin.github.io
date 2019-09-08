//
//  ViewController.m
//  ConflictingEvents
//
//  Created by Konstantin Klyatskin on 2019-09-06.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "ViewController.h"
#import "CEDataSource.h"
#import "CEEventCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"CEEventCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kCellID];
    self.tableView.delegate = self;
    self.tableView.dataSource = [CEDataSource shared]; // initialize data preparation
}

#pragma mark - UITableViewDelegate

// disable cell selection
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
