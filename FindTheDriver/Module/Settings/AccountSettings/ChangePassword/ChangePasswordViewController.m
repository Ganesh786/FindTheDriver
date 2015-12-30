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
    self.view.tintColor=kNavBarColor;

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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveBtnClicked:(id)sender {
    NSString *oldPwd=[SCUIUtility validateString:_currentPwdTxtfld.text];
    NSString *newPwd=[SCUIUtility validateString:_nePwdTextfld.text];
    if (oldPwd.length>0 || newPwd.length>0) {
        if (oldPwd.length>0) {
            if (newPwd.length>0) {
                [_currentPwdTxtfld resignFirstResponder];
                [_nePwdTextfld resignFirstResponder];
                [[CustomLoaderView sharedView] showLoader];
                [[ChangePasswordModel alloc]changePwdAPICall:[NSString stringWithFormat:@"%@/%@/%@",[SCDataUtility getUserName],oldPwd,newPwd] completionBlock:^(BOOL success, NSString *message, id dataDict) {
                    if (success) {
                        DEBUGLOG(@"message ->%@ dataDict ->%@",message,dataDict);
                        [[CustomLoaderView sharedView] dismissLoader];
                        [[NSUserDefaults standardUserDefaults]setObject:newPwd forKey:USER_PASSWORD];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [self showAlert:@"" message:message];
                    }
                }];
            }else{
                [self showAlert:@"" message:@"Please Enter New Password"];
            }
        }else{
            [self showAlert:@"" message:@"Please Enter Current Password"];
        }

    }else{
        [self showAlert:@"" message:@"Please Enter a Current Password and New Password"];
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
