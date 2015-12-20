//
//  TodayLogDetailViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 17/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "TodayLogDetailViewController.h"
#import "TodayLogDetailCustomTableViewCell.h"
#import "TodayLogDetailStatusTableViewCell.h"

@interface TodayLogDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSMutableArray *detailTableArray;
    UIToolbar *accessoryBar;
    UIDatePicker *datePicker;
}
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *logDetailTableView;

@property (weak, nonatomic) IBOutlet UIView *topGraphView;
@property(nonatomic,strong)GraphView *graphComponent;
@end

@implementation TodayLogDetailViewController

#define kTitle  @"Title"
#define kValue  @"Value"
#define kMessage  @"Message"

static NSString *kStartTime   = @"Start Time";
static NSString *kEndTime   = @"End Time";
static NSString *kStatusCell   = @"Status Cell";
static NSString *kLocation   = @"Location";
static NSString *kAddRemark   = @"Add Remark";

static NSString *kStartTimeMessage =@"Enter Start Time";
static NSString *kEndTimeMessage =@"Enter End Time";
static NSString *kStatusCellMessage =@"";
static NSString *kLocationMessage =@"Enter Location";
static NSString *kAddRemarkMessage =@"Add Remark";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpView];
}

-(void)setUpView{
    self.graphComponent=[GraphView sharedComponent];
    [self.topGraphView addSubview:self.graphComponent];
    
    self.logDetailTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.logDetailTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.navigationItem.title=@"Monday | 10 Oct 2015";
    self.tabBarController.tabBar.hidden=YES;
    
    detailTableArray=[[NSMutableArray alloc]init];
    [detailTableArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"",kStartTime,kStartTimeMessage] forKeys:@[kValue,kTitle,kMessage]]];
    [detailTableArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"",kEndTime,kEndTimeMessage] forKeys:@[kValue,kTitle,kMessage]]];
    [detailTableArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"",kStatusCell,kStatusCellMessage] forKeys:@[kValue,kTitle,kMessage]]];
    [detailTableArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"",kLocation,kLocationMessage] forKeys:@[kValue,kTitle,kMessage]]];
    [detailTableArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"",kAddRemark,kAddRemarkMessage] forKeys:@[kValue,kTitle,kMessage]]];

}

- (IBAction)SaveChangesBtnAction:(id)sender {
    
}

- (IBAction)InsertPastDutyStatusBtnAction:(id)sender {
    
}

#pragma mark:-UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return detailTableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[detailTableArray objectAtIndex:indexPath.row];
    if ([[dict objectForKey:kTitle] isEqualToString:kStatusCell]) {
        return 130;
    }
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *detailCustomCellIdentifier=@"TodayLogDetailCustomTableViewCell";
    static NSString *logDetailStatusCellIdentifier=@"TodayLogDetailStatusTableViewCell";
      NSDictionary *dict=[detailTableArray objectAtIndex:indexPath.row];
    if ([[dict objectForKey:kTitle] isEqualToString:kStatusCell]) {
        TodayLogDetailStatusTableViewCell *logStatusCell=[tableView dequeueReusableCellWithIdentifier:logDetailStatusCellIdentifier forIndexPath:indexPath];
        [logStatusCell.offDutyBtnOutlet addTarget:self action:@selector(offDutyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [logStatusCell.sleeperBtnOutlet addTarget:self action:@selector(sleeperBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [logStatusCell.drivingBtnOutlet addTarget:self action:@selector(drivingBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [logStatusCell.onDutyBtnOutlet addTarget:self action:@selector(onDutyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        return logStatusCell;
    }
    TodayLogDetailCustomTableViewCell *logDetailCell=[tableView dequeueReusableCellWithIdentifier:detailCustomCellIdentifier forIndexPath:indexPath];
    logDetailCell.detailCellTextField.placeholder=[dict objectForKey:kTitle];
    logDetailCell.detailCellTextField.text=[dict objectForKey:kValue];
    if ([[dict objectForKey:kTitle] isEqualToString:kStartTime]) {
        [logDetailCell.detaiCellBtnOutlet setBackgroundImage:[UIImage imageNamed:@"Timer"] forState:UIControlStateNormal];
        [logDetailCell.detaiCellBtnOutlet addTarget:self action:@selector(startTimeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }else if ([[dict objectForKey:kTitle] isEqualToString:kEndTime]) {
        [logDetailCell.detaiCellBtnOutlet setBackgroundImage:[UIImage imageNamed:@"Timer"] forState:UIControlStateNormal];
        [logDetailCell.detaiCellBtnOutlet addTarget:self action:@selector(endTimeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }else if ([[dict objectForKey:kTitle] isEqualToString:kLocation]) {
        [logDetailCell.detaiCellBtnOutlet setBackgroundImage:[UIImage imageNamed:@"LocationGray"] forState:UIControlStateNormal];
        [logDetailCell.detaiCellBtnOutlet addTarget:self action:@selector(locationBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }else if ([[dict objectForKey:kTitle] isEqualToString:kAddRemark]) {
        [logDetailCell.detaiCellBtnOutlet setBackgroundImage:[UIImage imageNamed:@"LogPreviewDisable"] forState:UIControlStateNormal];
        [logDetailCell.detaiCellBtnOutlet addTarget:self action:@selector(addRemarkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([[dict objectForKey:kTitle] isEqualToString:kStartTime] || [[dict objectForKey:kTitle] isEqualToString:kEndTime]) {
        logDetailCell.detailCellTextField.inputView = [self initializeTextFieldInputView];
        logDetailCell.detailCellTextField.inputAccessoryView=[self inputAccessoryViewForStatus];
    }else{
        logDetailCell.detailCellTextField.inputView = nil;
        logDetailCell.detailCellTextField.inputAccessoryView = nil;
        [logDetailCell.detailCellTextField reloadInputViews];
    }
    return logDetailCell;

}


#pragma mark:- Date picker methods

-(UIView*)inputAccessoryViewForStatus{
    if (!accessoryBar) {
        accessoryBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,44)];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(statusDoneAction:)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [accessoryBar setItems:@[flexibleSpace,doneButton]];
    }
    return accessoryBar;
}

-(void)statusDoneAction:(id)sender{
    UITextField *textfield =  (UITextField*)[self.logDetailTableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    NSIndexPath *indexPath = [self indexPathForView:textfield];
    NSString *datePickerTitle=[self getTitleForIndexPath:indexPath];
    if ([datePickerTitle isEqualToString:kStartTime] || [datePickerTitle isEqualToString:kEndTime]) {
        [self dateUpdated:datePicker];
        [self setValueForIndexPath:indexPath withValue:[[self formatter] stringFromDate:[datePicker date]]];
    }
    [self.logDetailTableView focusNextTextField];
}


- (UIView*)initializeTextFieldInputView{
    if (!datePicker) {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        datePicker.datePickerMode = UIDatePickerModeTime;
        datePicker.maximumDate=[NSDate date];
        datePicker.minuteInterval=1;
        datePicker.backgroundColor = [UIColor whiteColor];
        [datePicker addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    }
    return datePicker;
}

- (void)dateUpdated:(UIDatePicker *)datePick{
    UITextField *textfield =  (UITextField*)[self.logDetailTableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    textfield.text = [[self formatter] stringFromDate:[datePick date]];
}

-(NSDateFormatter*)formatter{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"hh:mm a"];
    return dateFormat;
}


-(void)offDutyBtnAction{
    
}

-(void)sleeperBtnAction{
    
}

-(void)drivingBtnAction{
    
}

-(void)onDutyBtnAction{
    
}

-(void)startTimeBtnAction{
    
}

-(void)endTimeBtnAction{
    
}

-(void)locationBtnAction{
    
}

-(void)addRemarkBtnAction{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Helper Method

-(NSString*)getTitleForIndexPath:(NSIndexPath*)indexPath
{
    id content = [detailTableArray objectAtIndex:indexPath.row];
    if ([content isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary*)content objectForKey:kTitle];
    }else{
        return (NSString*)content;
    }
}

-(void)setValueForIndexPath:(NSIndexPath*)indexPath withValue:(NSString*)value{
    NSMutableDictionary *content = [detailTableArray objectAtIndex:indexPath.row];
    [content setValue:value forKey:kValue];
}

-(NSString*)getValueForIndexPath:(NSIndexPath*)indexPath{
    id content = [detailTableArray objectAtIndex:indexPath.row];
    if ([content isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary*)content objectForKey:kValue];
    }else{
        return (NSString*)content;
    }
}

-(NSIndexPath*)indexPathForView:(UIView*)view{
    while (view && ![view isKindOfClass:[UITableViewCell class]])
        view = view.superview;
    return [self.logDetailTableView indexPathForRowAtPoint:view.center];
}

-(NSString*)getTitleForCurrentTextfield{
    UITextField *textfield =  (UITextField*)[self.logDetailTableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    NSIndexPath *indexPath = [self indexPathForView:textfield];
    return [self getTitleForIndexPath:indexPath];
}

#pragma mark:-UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSIndexPath *indexPath = [self indexPathForView:textField];
    NSString *title = [self getTitleForIndexPath:indexPath];
    if ([title isEqualToString:kLocation]) {
       //Start Locations
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
        NSIndexPath *indexPath = [self indexPathForView:textField];
        [self setValueForIndexPath:indexPath withValue:textField.text];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self.logDetailTableView focusNextTextField]) {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)resignKeyBoard{
    [[self.logDetailTableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view] resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
