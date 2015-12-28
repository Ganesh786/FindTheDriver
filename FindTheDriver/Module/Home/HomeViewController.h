//
//  HomeViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 02/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "CustomHomeActionViewController.h"

@interface HomeViewController : UIViewController<CustomHomeActionViewControllerDelegate>

@property(nonatomic, retain) IBOutlet CustomHomeActionViewController *customHomeActionViewController;

@end
