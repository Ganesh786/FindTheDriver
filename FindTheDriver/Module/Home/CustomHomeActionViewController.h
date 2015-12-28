//
//  CustomHomeActionViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 10/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomHomeActionViewControllerDelegate <NSObject>
@required
-(void)selectedDutyStatus:(NSInteger)changeStatus;
@end

@interface CustomHomeActionViewController : UIViewController
@property(nonatomic,weak)id<CustomHomeActionViewControllerDelegate>delegate;
@end
