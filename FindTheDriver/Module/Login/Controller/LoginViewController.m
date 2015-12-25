//
//  LoginViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 24/11/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RegistrationViewController.h"
#import "HomeViewController.h"
#import "MFSideMenuContainerViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtFld;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *hideView;

@end

@implementation LoginViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _hideView.hidden=NO;

    _loginBtn.layer.cornerRadius = 8;
    _loginBtn.clipsToBounds = YES;
    _emailTxtFld.delegate = self;
    _passwordTxtFld.delegate = self;

    self.view.tintColor=kNavBarColor;
    
    [self setBackBarButtonItem];
    UIAppDelegate.navigationController = self.navigationController;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _hideView.hidden=YES;
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:USER_LOGGEDIN];
//    [[NSUserDefaults standardUserDefaults]setObject:@"shreeshailg51@gmail.com" forKey:USER_NAME];
//    [[NSUserDefaults standardUserDefaults]setObject:@"123456" forKey:USER_PASSWORD];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:USER_LOGGEDIN]) {
        [self loadDashboardView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden  = YES;
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

#pragma mark - User action methods

- (IBAction)loginBtnClicked:(id)sender {
    NSString *email=[SCUIUtility validateString:_emailTxtFld.text];
    NSString *password=[SCUIUtility validateString:_passwordTxtFld.text];
    if (email.length>0 || password.length>0) {
        if (email.length>0) {
            if ([SCUIUtility validateEmailWithString:_emailTxtFld.text]) {
                if (password.length>0) {
                    [_emailTxtFld resignFirstResponder];
                    [_passwordTxtFld resignFirstResponder];
                    [[CustomLoaderView sharedView] showLoader];
                    [[LoginModel alloc]loginAPICall:[NSString stringWithFormat:@"%@/%@",email,password] completionBlock:^(BOOL success, NSString *message, id dataDict) {
                        [[CustomLoaderView sharedView] dismissLoader];
                        if (success) {
                            DEBUGLOG(@"message ->%@ dataDict ->%@",message,dataDict);
                            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:USER_LOGGEDIN];
                            [[NSUserDefaults standardUserDefaults]setObject:email forKey:USER_NAME];
                            [[NSUserDefaults standardUserDefaults]setObject:password forKey:USER_PASSWORD];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self loadDashboardView];
                        }else{
                            [self showAlert:@"" message:message];
                        }
                    }];
                }else{
                    [self showAlert:@"" message:@"Please Enter Password"];
                }
            }else{
                [self showAlert:@"" message:@"Please Enter a Valid Email ID"];
            }
        }else{
            [self showAlert:@"" message:@"Please Enter Email ID"];
        }
 
    }else{
        [self showAlert:@"" message:@"Please Enter a Valid Email ID and Password"];
    }
}

- (void)loadDashboardView {
    
    HomeViewController *homeViewController = [kHomeStoryboard instantiateInitialViewController];

    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *)homeViewController;
    UINavigationController *navigationController = [kHomeStoryboard instantiateViewControllerWithIdentifier:@"navigationController"];
    UIViewController *leftSideMenuViewController = [kHomeStoryboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setCenterViewController:navigationController];
    [self.navigationController pushViewController:homeViewController animated:NO];
}

- (IBAction)registeredBtnClicked:(id)sender {
    RegistrationViewController *registrationVC = [kLoginStoryboard instantiateViewControllerWithIdentifier:@"RegistrationID"];
    [self.navigationController pushViewController:registrationVC animated:YES];
}

- (IBAction)helpBtnClicked:(id)sender {
    NSString *email=[SCUIUtility validateString:_emailTxtFld.text];
    if (email.length>0) {
        if ([SCUIUtility validateEmailWithString:_emailTxtFld.text]) {
            [_emailTxtFld resignFirstResponder];
            [_passwordTxtFld resignFirstResponder];
            Forgot_PasswordViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPwdID"];
            self.forgotPwdViewController = myController;
            self.forgotPwdViewController.userName=email;
            [self.navigationController.view addSubview:self.forgotPwdViewController.view];
        }else{
            [self showAlert:@"" message:@"Please Enter a Valid Email ID"];
        }
    }else{
        [self showAlert:@"" message:@"Please Enter Email ID"];
    }
}

#pragma mark - UItextfiled delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self setLayoutViewAnimationWithView:self.view OriginX:0 OriginY:-175];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwordTxtFld)
        [self setLayoutViewAnimationWithView:self.view OriginX:0 OriginY:0];
    
    if (textField == self.emailTxtFld) {
        [self.emailTxtFld resignFirstResponder];
        [self.passwordTxtFld becomeFirstResponder];
        
    } else if (textField == self.passwordTxtFld)
        [self.view endEditing:YES];
    
    return YES;
}

- (void)setLayoutViewAnimationWithView:(UIView *)layoutView OriginX:(float)xValue OriginY:(float )yValue {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    layoutView.frame = CGRectMake(xValue, yValue, layoutView.frame.size.width, layoutView.frame.size.height);
    [UIView commitAnimations];
}

@end
