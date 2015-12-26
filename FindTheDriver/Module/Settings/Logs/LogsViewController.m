//
//  LogsViewController.m
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 11/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "LogsViewController.h"
#import "LogsCellOneTableViewCell.h"
#import "LogsCellTwoTableViewCell.h"

@interface LogsViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    NSMutableArray *tableDataArray;
    UIToolbar *accessoryBar;
    UIDatePicker *datePicker;
    
    UIPickerView *docTypePicker;
    NSArray *timePickerArray;
    NSArray *cyclePickerArray;
    NSArray *pickerArray;
}
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@end

@implementation LogsViewController

#define kTitle  @"Title"
#define kValue  @"Value"
#define kImage @"Image"

#define kSubValue  @"SubValue"
#define kSelectedLogOrMeter  @"LogORMeter"

static NSString *kTimeZone   = @"Home Terminal Time Zone";
static NSString *kCycle   = @"Cycle";
static NSString *kOdometer   = @"Odometer";
static NSString *kLogIncrement   = @"Log Increment";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Logs";
    
    self.view.tintColor=kNavBarColor;
    self.tableView.tintColor=kNavBarColor;
    
    timePickerArray=[NSArray arrayWithObjects:@"Central Time",@"GMT",@"IST", nil];
    cyclePickerArray=[NSArray arrayWithObjects:@"US 70 Hours/8 Days",@"US 80 Hours/8 Days",@"US 70 Hours/7 Days", nil];

    tableDataArray=[[NSMutableArray alloc]init];
    [tableDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"Central Time",kTimeZone,@"Calender"] forKeys:@[kValue,kTitle,kImage]]];
    [tableDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"US 70 Hours/8 Days",kCycle,@"Calender"] forKeys:@[kValue,kTitle,kImage]]];
    
    [tableDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"KiloMeters",kOdometer,@"Miles",@"Calender",@"KiloMeters"] forKeys:@[kValue,kTitle,kSubValue,kImage,kSelectedLogOrMeter]]];
    [tableDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"1 Minute",kLogIncrement,@"15 Minute",@"Calender",@"1 Minute"] forKeys:@[kValue,kTitle,kSubValue,kImage,kSelectedLogOrMeter]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark:- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellOneID = @"LogsCellOneTableViewCell";
    static NSString *CellTwoID = @"LogsCellTwoTableViewCell";
    
    NSDictionary *dict=[tableDataArray objectAtIndex:indexPath.row];
    if ([[dict objectForKey:kTitle] isEqualToString:kTimeZone] || [[dict objectForKey:kTitle] isEqualToString:kCycle]) {
        LogsCellOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellOneID forIndexPath:indexPath];
        cell.steeringImgView.image=[UIImage imageNamed:[dict objectForKey:kImage]];
        cell.titleLabel.text=[dict objectForKey:kTitle];
        cell.cycleTextField.placeholder=[dict objectForKey:kValue];
        cell.cycleTextField.text=[dict objectForKey:kValue];
        cell.cycleTextField.inputView = [self inputViewForStatus];
        cell.cycleTextField.inputAccessoryView=[self inputAccessoryViewForStatus];
        return cell;
    }
    
    LogsCellTwoTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellTwoID forIndexPath:indexPath];
    cell2.steeringImgView.image=[UIImage imageNamed:[dict objectForKey:kImage]];
    cell2.titleLabel.text=[dict objectForKey:kTitle];
    cell2.leftToggleLabel.text=[dict objectForKey:kValue];
    cell2.rightToggleLabel.text=[dict objectForKey:kSubValue];
    [cell2.leftToggleBtnOutlet addTarget:self action:@selector(leftToggleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell2.rightToggleBtnOutlet addTarget:self action:@selector(rightToggleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell2.leftToggleBtnOutlet setImage:nil forState:UIControlStateNormal];
    [cell2.rightToggleBtnOutlet setImage:nil forState:UIControlStateNormal];
    if ([[dict objectForKey:kValue] isEqualToString:[dict objectForKey:kSelectedLogOrMeter]]) {
        [cell2.leftToggleBtnOutlet setBackgroundImage:[UIImage imageNamed:@"CheckMark"] forState:UIControlStateNormal];//Selected Image
        [cell2.rightToggleBtnOutlet setBackgroundImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];// Unselected Image
    }else{
        [cell2.leftToggleBtnOutlet setBackgroundImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];//Unselected Image
        [cell2.rightToggleBtnOutlet setBackgroundImage:[UIImage imageNamed:@"CheckMark"] forState:UIControlStateNormal];// Selected Image
    }
    return cell2;
}

-(void)leftToggleBtnAction:(UIButton*)sender{
    UIButton *button = (UIButton*)sender;
    NSIndexPath *indexPath = [self indexPathForView:button];
//    NSString *title=[self getTitleForIndexPath:indexPath];
    NSMutableDictionary *dict=[tableDataArray objectAtIndex:indexPath.row];
    if (![[dict objectForKey:kValue] isEqualToString:[dict objectForKey:kSelectedLogOrMeter]]) {
        [dict setObject:[dict objectForKey:kValue] forKey:kSelectedLogOrMeter];
        NSRange range=NSMakeRange(0, 1);
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)rightToggleBtnAction:(UIButton*)sender{
    UIButton *button = (UIButton*)sender;
    NSIndexPath *indexPath = [self indexPathForView:button];
    //    NSString *title=[self getTitleForIndexPath:indexPath];
    NSMutableDictionary *dict=[tableDataArray objectAtIndex:indexPath.row];
    if (![[dict objectForKey:kSubValue] isEqualToString:[dict objectForKey:kSelectedLogOrMeter]]) {
        [dict setObject:[dict objectForKey:kSubValue] forKey:kSelectedLogOrMeter];
        NSRange range=NSMakeRange(0, 1);
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(UIView*)inputAccessoryViewForStatus{
    if (!accessoryBar) {
        accessoryBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,44)];
        accessoryBar.backgroundColor=kNavBarColor;
        accessoryBar.translucent=YES;
        accessoryBar.barTintColor=kNavBarColor;
        [[UIBarButtonItem appearance]setTintColor:kWhiteColor];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(statusDoneAction:)];
        //        [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor} forState:UIControlStateNormal];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [accessoryBar setItems:@[flexibleSpace,doneButton]];
    }
    return accessoryBar;
}

-(UIView*)inputViewForStatus{
    if (!docTypePicker) {
        [docTypePicker removeFromSuperview];
        docTypePicker=nil;
    }
    docTypePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    docTypePicker.backgroundColor=kClearColor;
    docTypePicker.delegate = self;
    docTypePicker.dataSource = self;
    [docTypePicker reloadAllComponents];
    return docTypePicker;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerArray.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self getPickerSelectedValueForRow:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITextField *textfield =  (UITextField*)[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    textfield.text = [self getPickerSelectedValueForRow:row];
}

-(NSString*)getPickerSelectedValueForRow:(NSInteger)row{
    NSString *datePickerTitle = [self getTitleForCurrentTextfield];
    if ([datePickerTitle isEqualToString:kTimeZone] || [datePickerTitle isEqualToString:kCycle]) {
        return [pickerArray objectAtIndex:row];
    }
    return nil;
}

-(void)statusDoneAction:(id)sender{
    UITextField *textfield =  (UITextField*)[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    NSIndexPath *indexPath = [self indexPathForView:textfield];
    NSString *title=[self getTitleForIndexPath:indexPath];
    [self setValueForIndexPath:indexPath withValue:[self getPickerSelectedValueForRow:[docTypePicker selectedRowInComponent:0]]];
    if ([title isEqualToString:kTimeZone]) {
        [self.tableView focusNextTextField];
    }else{
        [self resignKeyBoard];
    }
}

#pragma mark - Helper Method

-(NSString*)getTitleForIndexPath:(NSIndexPath*)indexPath
{
    id content = [tableDataArray objectAtIndex:indexPath.row];
    if ([content isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary*)content objectForKey:kTitle];
    }else{
        return (NSString*)content;
    }
}

-(void)setValueForIndexPath:(NSIndexPath*)indexPath withValue:(NSString*)value{
    NSMutableDictionary *content = [tableDataArray objectAtIndex:indexPath.row];
    [content setValue:value forKey:kValue];
}

-(NSString*)getValueForIndexPath:(NSIndexPath*)indexPath{
    id content = [tableDataArray objectAtIndex:indexPath.row];
    if ([content isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary*)content objectForKey:kValue];
    }else{
        return (NSString*)content;
    }
}

-(NSIndexPath*)indexPathForView:(UIView*)view{
    while (view && ![view isKindOfClass:[UITableViewCell class]])
        view = view.superview;
    return [self.tableView indexPathForRowAtPoint:view.center];
}

-(NSString*)getTitleForCurrentTextfield{
    UITextField *textfield =  (UITextField*)[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    NSIndexPath *indexPath = [self indexPathForView:textfield];
    return [self getTitleForIndexPath:indexPath];
}

#pragma mark:-UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSIndexPath *indexPath = [self indexPathForView:textField];
    NSString *title = [self getTitleForIndexPath:indexPath];
    if ([title isEqualToString:kTimeZone]) {
        pickerArray=[timePickerArray copy];
    }else if ([title isEqualToString:kCycle]) {
        pickerArray=[cyclePickerArray copy];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSIndexPath *indexPath = [self indexPathForView:textField];
    [self setValueForIndexPath:indexPath withValue:textField.text];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self.tableView focusNextTextField]) {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)resignKeyBoard{
    [[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view] resignFirstResponder];
}

- (IBAction)btnSaveClicked:(id)sender {
}

- (IBAction)btnCancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
