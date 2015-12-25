//
//  NotificationsViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 08/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;
- (IBAction)NotificationSwitchAction:(id)sender;

@end
