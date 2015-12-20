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
    self.revealViewController.delegate=self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];
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
            [self.navigationController pushViewController:homevc animated:YES];
            [homevc revealToggle];
            break;
        }
        case 1: {
            LogsInfoViewController *logsInfovc = [kLogsStoryboard instantiateViewControllerWithIdentifier:@"LogsInfoID"];
            [self.navigationController pushViewController:logsInfovc animated:YES];
            [logsInfovc revealToggle];
            break;
        }
        case 2: {
            InspectLogsViewController *inspectLogsVC = [kLogsStoryboard instantiateViewControllerWithIdentifier:@"LogsTabBarID"];
            [inspectLogsVC.tabBarController setSelectedIndex:2];
            [self.navigationController pushViewController:inspectLogsVC animated:YES];
            break;
        }
        case 3: {
            SettingsViewController *settingsVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"SettingsID"];
            [self.navigationController pushViewController:settingsVC animated:YES];
            [settingsVC revealToggle];
            break;
        }

        default:
            break;
    }
}

#pragma mark - SWRevealViewController delegate methods

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position {
    if(position == FrontViewPositionLeft){
        [revealController.frontViewController.view setUserInteractionEnabled:YES];
        [revealController.frontViewController.revealViewController tapGestureRecognizer];
    } else
        [revealController.frontViewController.view setUserInteractionEnabled:NO];
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
