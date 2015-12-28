//
//  HomeViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 02/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeWeekDayTableViewCell.h"
#import "LKAddScoreView.h"
#import "MFSideMenu.h"
#import "AccountSettingsViewController.h"

@interface HomeViewController () <SWRevealViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate> {
    SWRevealViewController *revealController;
    NSArray *weekDayNameArray, *timeArray;
    LKAddScoreView *progressView;
    
    UIPickerView *pickerView;
    UIToolbar *accessoryBar;
    
    NSArray *vehiclesArray;
}
@property (weak, nonatomic) IBOutlet UIView *circularView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIView *violationsView;
@property (weak, nonatomic) IBOutlet UIButton *violationsBtn;

@property (weak, nonatomic) IBOutlet UIView *logsView;
@property (weak, nonatomic) IBOutlet UIButton *logsBtn;

@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UIButton *navBarRightBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeStatusBtnOutlet;

@property (weak, nonatomic) IBOutlet UILabel *todayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedCycleLabel;

//Top drop down view
@property (weak, nonatomic) IBOutlet UIView *topDropDownView;
@property (weak, nonatomic) IBOutlet UIImageView *topLeftImgView;
@property (weak, nonatomic) IBOutlet UILabel *topDropDownLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topDropDownImgView;
@property (weak, nonatomic) IBOutlet UIButton *topDropDownBtnOutlet;

//Break View
@property (weak, nonatomic) IBOutlet UIView *breakView;
@property (weak, nonatomic) IBOutlet UILabel *breakTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *breakLabel;
@property (weak, nonatomic) IBOutlet UIView *breakLineView;
//Drive View
@property (weak, nonatomic) IBOutlet UIView *driveView;
@property (weak, nonatomic) IBOutlet UILabel *driveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *driveLabel;
@property (weak, nonatomic) IBOutlet UIView *driveLineView;
//Shift View
@property (weak, nonatomic) IBOutlet UIView *shiftView;
@property (weak, nonatomic) IBOutlet UILabel *shiftTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shiftLabel;
@property (weak, nonatomic) IBOutlet UIView *shiftLineView;
//Cycle View
@property (weak, nonatomic) IBOutlet UIView *cycleView;
@property (weak, nonatomic) IBOutlet UILabel *cycleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;


@end

@implementation HomeViewController

- (IBAction)navBarProfileBtnAction:(id)sender {
    AccountSettingsViewController *accSettingsVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"AccountSettingsID"];
    [self.navigationController pushViewController:accSettingsVC animated:YES];
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    [self setNavigationBarNameWithNameAttribute:@"Dashboard"];
    [self setBackBarButtonItem];
    [self loadHomeViewComponents];
    
    _navBarRightBtn.layer.cornerRadius=_navBarRightBtn.frame.size.height/2;
    _navBarRightBtn.layer.masksToBounds=YES;
    [_navBarRightBtn setImage:[UIImage imageNamed:@"TopUserIcon"] forState:UIControlStateNormal];
    
    self.topDropDownImgView.image=[UIImage imageNamed:@"DownArrowBlue"];
    self.topDropDownImgView.contentMode=UIViewContentModeScaleAspectFit;
    self.topDropDownImgView.clipsToBounds=YES;
    
    self.topDropDownLabel.text=[SCDataUtility getSelectedVehicle];
    
    self.selectedCycleLabel.text=[SCDataUtility getSelectedCycle];
    self.todayDateLabel.text=[SCDataUtility getTodayDateForDashBoard];
    
    [self.violationsBtn setTitle:@"3" forState:UIControlStateNormal];
    [self.logsBtn setTitle:@"2" forState:UIControlStateNormal];
    
    self.driveTimeLabel.textColor=kDriveColor;
    
    [self.changeStatusBtnOutlet setImage:[UIImage imageNamed:@"DropDownBlue"] forState:UIControlStateNormal];
    self.changeStatusBtnOutlet.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.changeStatusBtnOutlet.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.changeStatusBtnOutlet.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.changeStatusBtnOutlet.imageEdgeInsets = UIEdgeInsetsMake(0, 0.0, 0.0, 10.0);

    if ([StoreManager sharedStoreManager].regVehiclesArray.count>0) {
        vehiclesArray=[StoreManager sharedStoreManager].regVehiclesArray;
    }else{
        [self getVehiclesData];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark:- Get Vehicles Data
-(void)getVehiclesData{
    [[CustomLoaderView sharedView] showLoader];
    [[GetVehicleModel alloc]getVehiclesAPICall:[NSString stringWithFormat:@"%@/%@",[SCDataUtility getUserName],[SCDataUtility getUserPassword]] completionBlock:^(BOOL success, NSString *message, id dataDict) {
        [[CustomLoaderView sharedView] dismissLoader];
        DEBUGLOG(@"GetVehicleModel message ->%@ dataDict ->%@",message,dataDict);
        if ([dataDict isKindOfClass:[NSArray class]]) {
            [StoreManager sharedStoreManager].regVehiclesArray=dataDict;
            vehiclesArray=dataDict;
        }
        if (!success) {
            [self showAlert:@"" message:message];
        }
    }];
}


- (IBAction)topDropDownBtnAction:(id)sender {
    [self.view addSubview:[self inputViewForStatus]];
    [self.view addSubview:[self inputAccessoryViewForStatus]];
}

#pragma mark:- UIPickerView Methods
-(UIView*)inputViewForStatus{
    if (!pickerView) {
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
        pickerView.backgroundColor=[UIColor whiteColor];
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
        [[UIBarButtonItem appearance]setTintColor:kWhiteColor];        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(statusDoneAction:)];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(statusCancelAction:)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [accessoryBar setItems:@[cancelButton,flexibleSpace,doneButton]];
    }
    return accessoryBar;
}

-(void)statusDoneAction:(id)sender{
    self.topDropDownLabel.text=[SCUIUtility validateString:[[vehiclesArray objectAtIndex:[pickerView selectedRowInComponent:0]] objectForKey:@"RegistrationNumber"]];
    [SCDataUtility storeSelectedVehicle:self.topDropDownLabel.text];
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
    return vehiclesArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [SCUIUtility validateString:[[vehiclesArray objectAtIndex:row] valueForKey:@"RegistrationNumber"]];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}



#pragma mark - User defined methods

- (IBAction)sideBarBtnClicked:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void)loadHomeViewComponents {
    
    _violationsView.layer.masksToBounds = YES;
    _logsView.layer.masksToBounds = YES;
    [SCUIUtility setLayerForView:_violationsView WithColor:kLightGrayColor];
    [SCUIUtility setLayerForView:_logsView WithColor:kLightGrayColor];
    weekDayNameArray = [NSArray arrayWithObjects:@"Sunday", @"Saturday", @"Friday", @"Thursday", @"Wednesday", @"TuesDay", @"Monday", nil];
    timeArray = [NSArray arrayWithObjects:@"10.45", @"09.25", @"07.03", @"02.45", @"00.00", @"00.00", @"00.00", nil];
    
    CGRect rect=CGRectMake(10, 0, 110, 110);
    progressView = [LKAddScoreView shareInstance:rect];
//    [progressView setFrame:CGRectMake(10, 0, 110, 110)];
    [progressView setBackgroundColor:kWhiteColor];
    progressView.layer.cornerRadius=rect.size.height/2;
    progressView.layer.borderWidth=5.0f;
    progressView.layer.borderColor=kLightGrayColor.CGColor;
    progressView.layer.masksToBounds=YES;
    [self.circularView addSubview:progressView];
    
    [self offDutyStatus];
}


#pragma mark - TableView Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return weekDayNameArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *defaultCellID = @"DefaultCellID";
    static NSString *dayNameCellID = @"WeekDayCellID";

    if (indexPath.row == 0) {
        UITableViewCell *defaultCell = [tableView dequeueReusableCellWithIdentifier:defaultCellID];
        defaultCell.textLabel.font = [UIFont fontWithName:kHelveticaNeueFontName size:14];
        defaultCell.textLabel.text = @"RECAP - WORKED HOURS";
        return defaultCell;
    }
    
    HomeWeekDayTableViewCell *weekCell = (HomeWeekDayTableViewCell *)[tableView dequeueReusableCellWithIdentifier:dayNameCellID];
    weekCell.dayNameLbl.text = weekDayNameArray[indexPath.row-1];
    weekCell.hoursLbl.text = timeArray[indexPath.row-1];;
    return weekCell;
}

- (IBAction)changeStatusBtnClicked:(id)sender {
    CustomHomeActionViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomHomeAction"];
    self.customHomeActionViewController = myController;
    self.customHomeActionViewController.delegate=self;
    
    [self.navigationController.view addSubview:self.customHomeActionViewController.view];
    [self.customHomeActionViewController viewWillAppear:NO];
}


#pragma mark:- CustomHomeActionViewControllerDelegate
-(void)selectedDutyStatus:(NSInteger)changeStatus{
    switch (changeStatus) {
        case 1:
            [self offDutyStatus];
            break;
        case 2:
            [self sleeperStatus];
            break;
        case 3:
            [self drivingStatus];
            break;
        case 4:
            [self onDutyStatus];
            break;
        default:
            break;
    }

}

-(void)offDutyStatus{
    [progressView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float minutes = 50;
    progressView.pregress.colors = @[(id)kGrayColor.CGColor,(id)kWhiteColor.CGColor];
    [progressView showMessage:@"OFF DUTY" subMes:[NSString stringWithFormat:@"%0.f MIN",minutes] fromScore:0 toScore:MIN(1, minutes/100) WithView:self.circularView];
}

-(void)sleeperStatus{
    [progressView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float minutes = 50;
    progressView.pregress.colors = @[(id)kDarkGrayColor.CGColor,(id)kWhiteColor.CGColor];
    [progressView showMessage:@"ON DUTY" subMes:[NSString stringWithFormat:@"%0.f MIN",minutes] fromScore:0 toScore:MIN(1, minutes/100) WithView:self.circularView];
}

-(void)drivingStatus{
    [progressView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float minutes = 70;
    progressView.pregress.colors = @[(id)kDriveColor.CGColor,(id)kWhiteColor.CGColor];
    [progressView showMessage:@"DRIVING" subMes:[NSString stringWithFormat:@"%0.f MIN",minutes] fromScore:0 toScore:MIN(1, minutes/100) WithView:self.circularView];
}

-(void)onDutyStatus{
    [progressView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float minutes = 50;
    progressView.pregress.colors = @[(id)kNavBarColor.CGColor,(id)kWhiteColor.CGColor];
    [progressView showMessage:@"ON DUTY" subMes:[NSString stringWithFormat:@"%0.f MIN",minutes] fromScore:0 toScore:MIN(1, minutes/100) WithView:self.circularView];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
