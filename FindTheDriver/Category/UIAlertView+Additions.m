//
//  UIAlertView+Additions.m
//  SkillsConnect
//
//  Created by Ganesh Korada on 07/11/14.
//
//

#import "UIAlertView+Additions.h"

@implementation UIAlertView (Additions)

+ (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message {
    
    [[[self alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

@end
