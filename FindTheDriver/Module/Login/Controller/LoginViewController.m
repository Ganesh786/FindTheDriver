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

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtFld;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _loginBtn.layer.cornerRadius = 8;
    _loginBtn.clipsToBounds = YES;
    _emailTxtFld.delegate = self;
    _passwordTxtFld.delegate = self;
    
    [self setBackBarButtonItem];
    UIAppDelegate.navigationController = self.navigationController;
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
    HomeViewController *homeViewController = [kHomeStoryboard instantiateInitialViewController];
    [self.navigationController pushViewController:homeViewController animated:NO];
}

- (IBAction)registeredBtnClicked:(id)sender {
    RegistrationViewController *registrationVC = [kLoginStoryboard instantiateViewControllerWithIdentifier:@"RegistrationID"];
    [self.navigationController pushViewController:registrationVC animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
