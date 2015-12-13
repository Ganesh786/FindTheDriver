//
//  InspectLogsViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "InspectLogsViewController.h"

@interface InspectLogsViewController ()

@end

@implementation InspectLogsViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellOneID = @"logsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellOneID forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:CellOneID];
    }
    return cell;
}

@end
