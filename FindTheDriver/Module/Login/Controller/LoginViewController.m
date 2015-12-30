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
    if ([[NSUserDefaults standardUserDefaults]boolForKey:USER_LOGGEDIN]) {
        [[CustomLoaderView sharedView]showLoader];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(taskCompleted) userInfo:nil repeats:NO];
    }else{
        _hideView.hidden=YES;
    }
}

-(void)taskCompleted{
    [[CustomLoaderView sharedView]dismissLoader];
    _hideView.hidden=YES;
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
                    if ([[SCDataUtility getUserName] isEqualToString:email] && [[SCDataUtility getUserPassword] isEqualToString:password]) {
                        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:USER_LOGGEDIN];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [self loadDashboardView];
                    }else{
                        [[CustomLoaderView sharedView] showLoader];
                        [[LoginModel alloc]loginAPICall:[NSString stringWithFormat:@"%@/%@",email,password] completionBlock:^(BOOL success, NSString *message, id dataDict) {
                            [[CustomLoaderView sharedView] dismissLoader];
                            if (success) {
                                DEBUGLOG(@"message ->%@ dataDict ->%@",message,dataDict);
                                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:USER_LOGGEDIN];
                                [[NSUserDefaults standardUserDefaults]setObject:email forKey:USER_NAME];
                                [[NSUserDefaults standardUserDefaults]setObject:password forKey:USER_PASSWORD];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                                
                                if ([[dataDict objectForKey:@"Profile"] isKindOfClass:[NSArray class]]) {
                                    [self parseProfileData:[dataDict objectForKey:@"Profile"]];
                                }
                                if ([[dataDict objectForKey:DUTY_CYCLE] isKindOfClass:[NSArray class]]) {
                                    [self parseDutyCycle:[dataDict objectForKey:DUTY_CYCLE]];
                                }
                                if ([[dataDict objectForKey:TIME_ZONE] isKindOfClass:[NSArray class]]) {
                                    [self parseTimeZone:[dataDict objectForKey:TIME_ZONE]];
                                }
                                if ([[dataDict objectForKey:CARRIER] isKindOfClass:[NSArray class]]) {
                                    [self parseCarrier:[dataDict objectForKey:CARRIER]];
                                }
                                if ([[dataDict objectForKey:VIOLATIONS] isKindOfClass:[NSArray class]]) {
                                    [self parseViolations:[dataDict objectForKey:VIOLATIONS]];
                                }
                                if ([[dataDict objectForKey:VIR_DEFECTS] isKindOfClass:[NSArray class]]) {
                                    [self parseVIRDefects:[dataDict objectForKey:VIR_DEFECTS]];
                                }
                                if ([[dataDict objectForKey:HOS_STATUS] isKindOfClass:[NSArray class]]) {
                                    [self parseHosStatus:[dataDict objectForKey:HOS_STATUS]];
                                }
                                if ([[dataDict objectForKey:EXCEPTIONS] isKindOfClass:[NSArray class]]) {
                                    [self parseExceptions:[dataDict objectForKey:EXCEPTIONS]];
                                }
                                [self loadDashboardView];
                            }else{
                                [self showAlert:@"" message:message];
                            }
                        }];
                    }
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

-(void)parseProfileData:(NSArray*)profileArray{
    if (profileArray.count>0) {
        NSDictionary *profileDict=[profileArray objectAtIndex:0];
        if ([profileDict isKindOfClass:[NSDictionary class]]) {
            NSData *data = [[NSData alloc] initWithData:[NSData dataFromBase64String:[profileDict objectForKey:@"ProfileImage"]]];
            UIImage *image = [UIImage imageWithData:data];
            [SCDataUtility writeGalleryImage:image imagename:PROFILE_PIC];
            [SCDataUtility storeDriverInfo:profileDict];
        }
    }
}

-(void)parseDutyCycle:(NSArray*)dutyCycleArray{
    if (dutyCycleArray.count>0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:dutyCycleArray forKey:DUTY_CYCLE];
            [SCDataUtility storeDutyCycle:dict];
    }
}

-(void)parseTimeZone:(NSArray*)timeZoneArray{
    if (timeZoneArray.count>0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:timeZoneArray forKey:TIME_ZONE];
        [SCDataUtility storeTimeZone:dict];
    }
}

-(void)parseCarrier:(NSArray*)dataArray{
    if (dataArray.count>0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:dataArray forKey:CARRIER];
        [SCDataUtility storeCarrier:dict];
    }
}

-(void)parseExceptions:(NSArray*)dataArray{
    if (dataArray.count>0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:dataArray forKey:EXCEPTIONS];
        [SCDataUtility storeExceptions:dict];
    }
}

-(void)parseHosStatus:(NSArray*)dataArray{
    if (dataArray.count>0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:dataArray forKey:HOS_STATUS];
        [SCDataUtility storeHosStatus:dict];
    }
}

-(void)parseVIRDefects:(NSArray*)dataArray{
    if (dataArray.count>0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:dataArray forKey:VIR_DEFECTS];
        [SCDataUtility storeVIRDefects:dict];
    }
}

-(void)parseViolations:(NSArray*)dataArray{
    if (dataArray.count>0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:dataArray forKey:VIOLATIONS];
        [SCDataUtility storeViolations:dict];
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
