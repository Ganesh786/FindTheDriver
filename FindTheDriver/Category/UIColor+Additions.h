//
//  UIColor+Additions.h
//  SkillsConnect
//
//  Created by Ganesh Korada on 16/12/14.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

/*!
 * Returns the color based on hexa string
 * @param hexString Assumes input like "#00FF00" (#RRGGBB).
 * @return UIColor
 */
+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
