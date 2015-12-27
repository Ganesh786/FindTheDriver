//
//  SettingsViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 06/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsCustomTableViewCell.h"
#import "AccountSettingsViewController.h"
#import "SignatureViewController.h"
#import "NotificationsViewController.h"
#import "CarrierViewController.h"
#import "LogsViewController.h"
#import "MFSideMenu.h"
#import "AboutUSViewController.h"

@interface SettingsViewController () {
    NSArray *settingNamesArray, *settingImgArray;
}

@property (weak, nonatomic) IBOutlet UITableView *settingsTblView;

@end

@implementation SettingsViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden  = NO;
    [self loadSettingsViewComponents];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (IBAction)sideBarBtnClicked:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void)loadSettingsViewComponents {
    [self setBackBarButtonItem];
    [self setNavigationBarNameWithNameAttribute:@"Settings"];
    
    _settingsTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    settingNamesArray = @[@"Account", @"Signature", @"Notifications", @"Carrier", @"Logs", @"About"];
    settingImgArray = @[@"Account.png", @"Signature.png", @"Notification.png", @"Carrier.png", @"SettingsLogs.png", @"About.png"];
}

#pragma mark - Tableview Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return settingNamesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *settingsID = @"SettingsCellID";
    
    SettingsCustomTableViewCell *settingsCell = (SettingsCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:settingsID];
    settingsCell.settingsImgView.image = [UIImage imageNamed:settingImgArray[indexPath.row]];
    settingsCell.settingsNameLbl.text = settingNamesArray[indexPath.row];
    return settingsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            AccountSettingsViewController *accSettingsVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"AccountSettingsID"];
            [self.navigationController pushViewController:accSettingsVC animated:YES];
            break;
        }
        case 1: {
            SignatureViewController *signatureVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"SignatureID"];
            [self.navigationController pushViewController:signatureVC animated:YES];
            break;
        }
        case 2: {
            NotificationsViewController *notificationVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"NotificationID"];
            [self.navigationController pushViewController:notificationVC animated:YES];
            break;
        }
        case 3: {
            CarrierViewController *carrierVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"CarrierID"];
            [self.navigationController pushViewController:carrierVC animated:YES];
            break;
        }
        case 4: {
            LogsViewController *logsVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"LogsID"];
            [self.navigationController pushViewController:logsVC animated:YES];
            break;
        }
        case 5: {
            AboutUSViewController *logsVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"AboutUSViewController"];
            [self.navigationController pushViewController:logsVC animated:YES];
            break;
        }
        default:
            break;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
