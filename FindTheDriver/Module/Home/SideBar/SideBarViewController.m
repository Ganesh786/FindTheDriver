//
//  SideBarViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 02/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "SideBarViewController.h"
#import "SideBarCustomTableViewCell.h"
#import "LogsInfoViewController.h"
#import "SWRevealViewController.h"
#import "SettingsViewController.h"
#import "InspectLogsViewController.h"
#import "HomeViewController.h"
#import "MFSideMenu.h"

@interface SideBarViewController () <SWRevealViewControllerDelegate> {
    NSArray *sideBarNamesArray, *sideBarImgsArray;
}

@property (weak, nonatomic) IBOutlet UITableView *sideBarTblView;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end

@implementation SideBarViewController

#pragma mark - View Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSideBarViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - User defined methods

- (void)loadSideBarViewComponents {
    sideBarNamesArray = [NSArray arrayWithObjects:@"Dashboard", @"Logs", @"Inspect Logs", @"Settings", nil];
    sideBarImgsArray = [NSArray arrayWithObjects:@"Dashboard.png", @"Logs.png", @"InspectedLog.png", @"Settings.png", nil];
    _sideBarTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_logoutBtn setImage:[UIImage imageNamed:@"Logout"] forState:UIControlStateNormal];
}

- (IBAction)logoutBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sideBarNamesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *sideBarInputCellID = @"SideBarCell";

    SideBarCustomTableViewCell *sideBarCell = (SideBarCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:sideBarInputCellID];
    sideBarCell.titleLbl.text = sideBarNamesArray[indexPath.row];
    sideBarCell.imgView.image = [UIImage imageNamed:sideBarImgsArray[indexPath.row]];
    return sideBarCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // Show the currosponding pages based on user action
    switch (indexPath.row) {
        case 0: {
            HomeViewController *homevc = [kHomeStoryboard instantiateViewControllerWithIdentifier:@"HomeID"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:homevc];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
        case 1: {
            LogsInfoViewController *logsInfovc = [kLogsStoryboard instantiateViewControllerWithIdentifier:@"LogsInfoID"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:logsInfovc];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
 
        case 2: {
            UIAppDelegate.isSideBarInspectLogsClicked = YES;
            
            UITabBarController *tabbarVC = [[UIStoryboard storyboardWithName:@"LogsStoryboard" bundle: [NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LogsTabBarID"];
            [tabbarVC setSelectedIndex:2];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:tabbarVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
        case 3: {
            SettingsViewController *settingsVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"SettingsID"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:settingsVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }

        default:
            break;
    }
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
