//
//  Forgot PasswordViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 11/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForgotPasswordDelegate <NSObject>

- (void)dismissTheForgotPasswordView;

@end

@interface Forgot_PasswordViewController : UIViewController

@property (nonatomic, weak) id<ForgotPasswordDelegate> delegate;
@property (nonatomic, assign) BOOL isFirstTime;

- (void)slideIn;
- (void)slideOut;


@end
