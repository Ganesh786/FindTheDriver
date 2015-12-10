//
//  HomeViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 02/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeWeekDayTableViewCell.h"

@interface HomeViewController () <SWRevealViewControllerDelegate> {
    SWRevealViewController *revealController;
    NSArray *weekDayNameArray, *timeArray;

}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *violationsView;
@property (weak, nonatomic) IBOutlet UIButton *violationsBtn;
@property (weak, nonatomic) IBOutlet UIView *logsView;
@property (weak, nonatomic) IBOutlet UIButton *logsBtn;

@end

@implementation HomeViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    [self setNavigationBarNameWithNameAttribute:@"Dashboard"];
    [self setBackBarButtonItem];
    [self loadHomeViewComponents];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [revealController panGestureRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [revealController removePanGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadHomeViewComponents {
    revealController = [self revealViewController];
    revealController.delegate = self;
    [revealController tapGestureRecognizer];

    UIAppDelegate.revealViewController = self.revealViewController;
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);

    self.revealViewController.toggleAnimationType = SWRevealToggleAnimationTypeEaseOut;
    self.revealViewController.frontViewShadowRadius = 5;
    self.revealViewController.frontViewShadowColor = kGrayColor;
    self.revealViewController.frontViewShadowOffset = CGSizeMake(0, 1.5);
    [self.navigationController.navigationBar setBarTintColor:kNavBarColor];

    _violationsView.layer.masksToBounds = YES;
    _logsView.layer.masksToBounds = YES;
    [SCUIUtility setLayerForView:_violationsView WithColor:kLightGrayColor];
    [SCUIUtility setLayerForView:_logsView WithColor:kLightGrayColor];
    weekDayNameArray = [NSArray arrayWithObjects:@"Sunday", @"Saturday", @"Friday", @"Thursday", @"Wednesday", @"TuesDay", @"Monday", nil];
    timeArray = [NSArray arrayWithObjects:@"10.45", @"09.25", @"07.03", @"02.45", @"00.00", @"00.00", @"00.00", nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
