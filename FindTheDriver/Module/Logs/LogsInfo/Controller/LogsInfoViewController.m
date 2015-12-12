//
//  LogsInfoViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 05/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "LogsInfoViewController.h"
#import "CustomLogsInfoTableViewCell.h"
#import "TodayLogViewController.h"

@interface LogsInfoViewController ()  {

}

@property (weak, nonatomic) IBOutlet UITableView *logInfoTblView;

@end

@implementation LogsInfoViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden  = NO;
    [self loadLogsViewComponents];
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
    [UIAppDelegate.revealViewController revealToggleAnimated:YES];
}

- (void)loadLogsViewComponents {
    [self setBackBarButtonItem];
    [self setNavigationBarNameWithNameAttribute:@"Logs"];
    
    UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sideBar"] style:UIBarButtonItemStylePlain target:UIAppDelegate.revealViewController action:@selector(revealToggle:)];
    sidebarButton.tintColor = kWhiteColor;
    self.navigationItem.leftBarButtonItem = sidebarButton;
    [UIAppDelegate.revealViewController tapGestureRecognizer];
}

- (IBAction)calenderBtnClicked:(id)sender {
    CustomLogSearchViewController *myController = [kLogsStoryboard instantiateViewControllerWithIdentifier:@"LogSearchID"];
    self.customLogSearchViewController = myController;

    [self.navigationController.view addSubview:self.customLogSearchViewController.view];
    [self.customLogSearchViewController viewWillAppear:NO];
}

- (IBAction)logsScaleTransaparentBtnClicked:(id)sender {
    UITabBarController *tabbarController = (UITabBarController *)[kLogsStoryboard instantiateViewControllerWithIdentifier:@"LogsTabBarID"];
    [self.navigationController pushViewController:tabbarController animated:YES];
}

#pragma mark - Tableview Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *logInfoCellID = @"LogInfoCellID";
    
    CustomLogsInfoTableViewCell *customLogInfoCell = (CustomLogsInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:logInfoCellID];
    return customLogInfoCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
