//
//  UIColor+Additions.m
//  SkillsConnect
//
//  Created by Ganesh Korada on 16/12/14.
//
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    scanner.scanLocation = 1; // bypass '#' character
    [scanner scanHexInt:&rgbValue];

    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
