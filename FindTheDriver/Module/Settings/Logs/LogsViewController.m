//
//  LogsViewController.m
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 11/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "LogsViewController.h"

@interface LogsViewController ()

@end

@implementation LogsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Logs";
    _pickerCycle.hidden = YES;
    _pickerTimeZone.hidden = YES;
    _pickerTimeZone.delegate = self;
    _pickerCycle.delegate = self;
    _pickerCycle.backgroundColor = [UIColor lightGrayColor];
    _pickerTimeZone.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0)
    {
        return 200;
    }
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellOneID = @"CellOne";
    static NSString *CellTwoID = @"CellTwo";
    
    if (indexPath.row == 0)
    {
        LogsCellOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellOneID forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[LogsCellOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:CellOneID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.btnTimeZone.layer.cornerRadius = 5.0;
        cell.btnTimeZone.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        cell.btnTimeZone.layer.borderWidth = 2.0;
        [cell.btnTimeZone setTitle:@"\tCentral Time" forState:UIControlStateNormal];
        cell.btnTimeZone.tintColor = [UIColor blackColor];

        cell.btnCycle.layer.cornerRadius = 5.0;
        cell.btnCycle.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        cell.btnCycle.layer.borderWidth = 2.0;
        [cell.btnCycle setTitle:@"\tUS 70 Hours/8 Days" forState:UIControlStateNormal];
        cell.btnCycle.tintColor = [UIColor blackColor];
        
        cell.delegate = self;
        return cell;
    }
    else
    {
        LogsCellTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTwoID forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[LogsCellTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:CellTwoID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 1)
        {
            cell.lblTitle.text = @"Odometer";
            cell.lblToggleOne.text = @"Kilometers";
            cell.lblToggleTwo.text = @"Miles";
        }
        else
        {
            cell.lblTitle.text = @"Log Increment";
            cell.lblToggleOne.text = @"1 Minute";
            cell.lblToggleTwo.text = @"15 Minutes";
        }
        return cell;

    }
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _pickerCycle.hidden = YES;
    _pickerTimeZone.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == _pickerTimeZone)
    {
        NSArray *timeZoneArray = [[NSArray alloc]initWithObjects:@"Time Zone 1",@"Time Zone 2",@"Time Zone 3",@"Time Zone 4", @"Time Zone 5", nil];
        return timeZoneArray[row];
    }
    else
    {
        NSArray *cyclesArray = [[NSArray alloc]initWithObjects:@"Cycle 1",@"Cycle 2",@"Cycle 3",@"Cycle 4", @"Cycle 5", nil];
        return cyclesArray[row];
    }
}

- (void)showPicker:(BOOL)isTimeZone
{
    if (isTimeZone)
    {
        _pickerTimeZone.hidden = NO;
        [self.view bringSubviewToFront:_pickerTimeZone];
    }
    else
    {
        _pickerCycle.hidden = NO;
        [self.view bringSubviewToFront:_pickerCycle];
    }
}

- (IBAction)btnSaveClicked:(id)sender {
}

- (IBAction)btnCancelClicked:(id)sender {
}
@end
