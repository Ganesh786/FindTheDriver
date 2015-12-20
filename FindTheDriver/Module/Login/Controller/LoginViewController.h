//
//  LoginViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 24/11/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Forgot PasswordViewController.h"
#import "LoginModel.h"

@interface LoginViewController : UIViewController <ForgotPasswordDelegate>

@property (nonatomic, retain) IBOutlet Forgot_PasswordViewController *forgotPwdViewController;
@end
