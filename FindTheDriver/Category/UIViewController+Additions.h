//
//  UIViewController+Additions.h
//  SkillsConnect
//
//  Created by Ganesh Korada on 06/11/14.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (Additions)


/*!
 * @method      setLayoutViewAnimationWithView
 * @discussion  sets the input view frame with animation
 * @param       layoutView takes the view object as input parameter
 * @param       xValue takes the x origin value as input parameter
 * @param       yValue takes the x origin value as input parameter
 */
- (void)setLayoutViewAnimationWithView:(UIView *)layoutView OriginX:(float)xValue OriginY:(float )yValue;

/*!
 * @method      addGestureRecognizerToHideTheKeyboardWithView
 * @discussion  Used to add the Tap gesture to hide the keyboard
 * @param       view Current UIView
 */
- (void)addGestureRecognizerToHideTheKeyboardWithView:(UIView *)view;

/*!
 * Used to set the NavigationBar title
 * @param navTitle title of the nav bar
 */
- (void)setNavigationBarNameWithNameAttribute:(NSString *)navTitle;

/*!
 * Used to set the localized Back button
 */
- (void)setBackBarButtonItem;

/*!
 * Used to get the line border layer
 * @param colorCode is an String which has Hex value
 * @return CAShapeLayer
 */
- (CAShapeLayer *)getLineBorderLayerWithColorCode:(NSString *)colorCode;

/*!
 * show alert methods
 */
-(void)showAlert:(NSString*)title message:(NSString*)message;


@end
