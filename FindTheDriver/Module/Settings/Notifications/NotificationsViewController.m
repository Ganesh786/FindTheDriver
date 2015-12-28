//
//  NotificationsViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 08/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    BOOL notificationStatus;
    NSArray *hosAlertArray;
    
    UIPickerView *pickerView;
    UIToolbar *accessoryBar;
}

@property (weak, nonatomic) IBOutlet UIButton *timeLimitBtn;

@end

@implementation NotificationsViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNotificationsViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods
- (void)loadNotificationsViewComponents {
    
    [self setNavigationBarNameWithNameAttribute:@"Notifications"];
    [self setBackBarButtonItem];
    
     notificationStatus=[SCDataUtility getNotificationStatus];
    [self.notificationSwitch setOn:notificationStatus animated:YES];
    
    _timeLimitBtn.layer.cornerRadius = 3;
    _timeLimitBtn.layer.borderWidth = 1;
    _timeLimitBtn.layer.borderColor = kLightGrayColor.CGColor;
    
    hosAlertArray=@[@"Never",@"15 minutes before violation",@"30 minutes before violation",@"45 minutes before violation",@"1 hour before violation"];
    NSString *hosAlertType=[SCUIUtility validateString:[SCDataUtility getHOSNotificationAlertType]];
    if (!hosAlertType.length) {
        hosAlertType=[hosAlertArray objectAtIndex:0];
    }
    [self.timeLimitBtn setTitle:hosAlertType forState:UIControlStateNormal];
//    [self.timeLimitBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)];
    
    [self.timeLimitBtn setImage:[UIImage imageNamed:@"DownArrow"] forState:UIControlStateNormal];
    self.timeLimitBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.timeLimitBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.timeLimitBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.timeLimitBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0.0, 0.0, 20.0);

//    ⌄
}


- (IBAction)timeLimitBtnClicked:(id)sender {
    [self.view addSubview:[self inputViewForStatus]];
    [self.view addSubview:[self inputAccessoryViewForStatus]];
    NSString *stateLbl=[NSString stringWithFormat:@"%@",self.timeLimitBtn.titleLabel.text];
    if (![stateLbl isEqualToString:@"Select State"]) {
        NSInteger index=[hosAlertArray indexOfObject:stateLbl];
        [pickerView selectRow:index inComponent:0 animated:NO];
    }
}

#pragma mark:- UIPickerView Methods
-(UIView*)inputViewForStatus{
    if (!pickerView) {
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
        pickerView.backgroundColor=kClearColor;
        pickerView.delegate = self;
        pickerView.dataSource = self;
    }
    [pickerView reloadAllComponents];
    return pickerView;
}

-(UIView*)inputAccessoryViewForStatus{
    if (!accessoryBar) {
        accessoryBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-244, self.view.frame.size.width,44)];
        accessoryBar.backgroundColor=kNavBarColor;
        accessoryBar.translucent=YES;
        accessoryBar.barTintColor=kNavBarColor;
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(statusDoneAction:)];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(statusCancelAction:)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [accessoryBar setItems:@[cancelButton,flexibleSpace,doneButton]];
    }
    return accessoryBar;
}

-(void)statusDoneAction:(id)sender{
   NSString *text=[hosAlertArray objectAtIndex:[pickerView selectedRowInComponent:0]];
    [SCDataUtility setHOSNotificationAlertType:text];
    [self.timeLimitBtn setTitle:text forState:UIControlStateNormal];
    [pickerView removeFromSuperview];
    pickerView=nil;
    [accessoryBar removeFromSuperview];
    accessoryBar=nil;
}

-(void)statusCancelAction:(id)sender{
    [pickerView removeFromSuperview];
    pickerView=nil;
    [accessoryBar removeFromSuperview];
    accessoryBar=nil;
}

#pragma mark:- UIPickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return hosAlertArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [hosAlertArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}


- (IBAction)NotificationSwitchAction:(id)sender {
    if ([self.notificationSwitch isOn]) {
        notificationStatus=YES;
    }else{
        notificationStatus=NO;
    }
    [self.notificationSwitch setOn:notificationStatus animated:YES];
    [SCDataUtility setNotificationStatus:notificationStatus];
}
@end
