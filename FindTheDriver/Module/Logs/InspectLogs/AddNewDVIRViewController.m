//
//  AddNewDVIRViewController.m
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 14/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "AddNewDVIRViewController.h"
#import "AddNewDVIRCustomTableViewCell.h"

@interface AddNewDVIRViewController ()

@end

@implementation AddNewDVIRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellOneID = @"DVIRCell";
    AddNewDVIRCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellOneID forIndexPath:indexPath];
    if (cell == nil)
        cell = [[AddNewDVIRCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellOneID];
    return cell;
}
@end
