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
    [self.revealViewController panGestureRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.revealViewController removePanGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)revealToggle {
    [self.revealViewController revealToggleAnimated:YES];
}

- (void)loadSettingsViewComponents {
    [self setBackBarButtonItem];
    [self setNavigationBarNameWithNameAttribute:@"Settings"];
    
    UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sideBar"] style:UIBarButtonItemStylePlain target:UIAppDelegate.revealViewController action:@selector(revealToggle:)];
    sidebarButton.tintColor = kWhiteColor;
    self.navigationItem.leftBarButtonItem = sidebarButton;
    [self.revealViewController tapGestureRecognizer];
    
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
            [UIAppDelegate.navigationController pushViewController:accSettingsVC animated:YES];
            break;
        }
        case 1: {
            SignatureViewController *signatureVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"SignatureID"];
            [UIAppDelegate.navigationController pushViewController:signatureVC animated:YES];
            break;
        }
        case 2: {
            NotificationsViewController *notificationVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"NotificationID"];
            [UIAppDelegate.navigationController pushViewController:notificationVC animated:YES];
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
