//
//  NotificationsViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 08/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()
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
    _timeLimitBtn.layer.cornerRadius = 3;
    _timeLimitBtn.layer.borderWidth = 1;
    _timeLimitBtn.layer.borderColor = kLightGrayColor.CGColor;
}

- (IBAction)timeLimitBtnClicked:(id)sender {
    
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
