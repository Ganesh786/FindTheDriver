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

@interface HomeViewController () <SWRevealViewControllerDelegate> {
    SWRevealViewController *revealController;
    NSArray *weekDayNameArray, *timeArray;
    LKAddScoreView *progressView;
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
    
    self.selectedCycleLabel.text=[SCDataUtility getSelectedCycle];
    self.todayDateLabel.text=[SCDataUtility getTodayDateForDashBoard];
    
    [self.changeStatusBtnOutlet setImage:[UIImage imageNamed:@"DropDownBlue"] forState:UIControlStateNormal];
    self.changeStatusBtnOutlet.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.changeStatusBtnOutlet.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.changeStatusBtnOutlet.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.changeStatusBtnOutlet.imageEdgeInsets = UIEdgeInsetsMake(0, 0.0, 0.0, 10.0);

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
- (IBAction)topDropDownBtnAction:(id)sender {
    
    
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
    
    float minutes = 45;
    CGRect rect=CGRectMake(10, 0, 110, 110);
    progressView = [LKAddScoreView shareInstance:rect];
//    [progressView setFrame:CGRectMake(10, 0, 110, 110)];
    [progressView setBackgroundColor:kWhiteColor];
    progressView.layer.cornerRadius=55.0f;
    progressView.layer.borderWidth=5.0f;
    progressView.layer.borderColor=kLightGrayColor.CGColor;
    progressView.layer.masksToBounds=YES;
    [self.circularView addSubview:progressView];
    
    [progressView showMessage:@"DRIVING" subMes:[NSString stringWithFormat:@"%0.f MIN",minutes] fromScore:0 toScore:MIN(1, minutes/100) WithView:self.view];
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
    
    [self.navigationController.view addSubview:self.customHomeActionViewController.view];
    [self.customHomeActionViewController viewWillAppear:NO];
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
