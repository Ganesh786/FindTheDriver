//
//  UIAlertView+Additions.h
//  SkillsConnect
//
//  Created by Ganesh Korada on 07/11/14.
//
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Additions)
/**
*  Used to dispaly Alert
*
*  @param title   Alert Title
*  @param message Alert Message
*/
+ (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message;

@end
