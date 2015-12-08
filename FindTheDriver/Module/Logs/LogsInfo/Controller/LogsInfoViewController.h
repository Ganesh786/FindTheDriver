//
//  LogsInfoViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 05/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "CustomLogSearchViewController.h"

@interface LogsInfoViewController : UIViewController

@property(nonatomic, retain) IBOutlet CustomLogSearchViewController *customLogSearchViewController;

- (void)revealToggle;

@end
