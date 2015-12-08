//
//  ChangePasswordViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 07/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *currentPwdTxtfld;
@property (weak, nonatomic) IBOutlet UITextField *nePwdTextfld;

@end

@implementation ChangePasswordViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadChangePwdViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadChangePwdViewComponents {
    [self setNavigationBarNameWithNameAttribute:@"Change Password"];
    [self setBackBarButtonItem];
    
}

- (IBAction)cancelBtnClicked:(id)sender {
    
}

- (IBAction)saveBtnClicked:(id)sender {
    
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
