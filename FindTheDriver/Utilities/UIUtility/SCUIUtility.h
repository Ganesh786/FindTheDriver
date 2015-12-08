//
//  SCUIUtility.h
//  SkillsConnectBusiness
//
//  Created by Dinesh A. Kumar on 6/16/15.
//  Copyright (c) 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCUIUtility : NSObject

/*!
 * Used to set the attributes for textfields
 * @param txtFld As an UITextfield used to change the attributes
 * @param txt    txt As an NSString used to change set the placeholder name
 * @param color  color As an UIColor used to set the color
 */
+ (void)setAttributesForTextField:(UITextField *)txtFld
              WithPlaceholderText:(NSString *)txt
                    WithTextColor:(UIColor *)color;

/*!
 * Used to set the leftImage for the textfld
 * @param txtFld as an UITextField used to set the leftview
 * @param img    as an UIImage used to set the left image
 */
+ (void)setLeftViewForTheTextField:(UITextField *)txtFld WithImage:(UIImage *)img;

/*!
 * Used to set the underline for the button text
 * @param btn as an UIButton object
 */
+ (void)setUnderlineForTheButton:(UIButton *)btn;

/*!
 * Used to get the custom no results label
 * @param frame   is an CGRect
 * @param textStr is an string which we need to display
 * @return UILabel
 */
+ (UILabel *)getNoResultsLabelWithFrame:(CGRect)frame WithText:(NSString *)textStr;

/*!
 * Used to get the custom back button
 * @return UIView
 */
+ (UIView *)getCustomBackButton;

/*!
 * Used to set the bar button appearance
 * @param color is an input paramater
 */
+ (void)setBarButtonAppearanceWithColor:(UIColor *)color;

/*!
 * @method      setLayerForView
 * @discussion  Used to set the layer attributes for the View
 * @param       view is an UIView object which can be used to set the layout
 */
+ (void)setLayerForView:(UIView *)view WithColor:(UIColor *)color;


/*!
 * @method      addStarAtEndOfString
 * @discussion  Used to add star at the end of passed string
 * @param       labelStr is a NSString object to which this method adds star at end with color
 * @return      NSString
 */
+ (NSAttributedString*)addStarAtEndOfString:(NSString*)labelStr WithColor:(UIColor *)color;

/*!
 * Used to add the shadow effect for the buttons
 * @param sender UIButton object
 */
+ (void)addShadowEffectForTheButton:(UIButton *)sender;

+ (void)removeCellSeparatorInsetForCell:(UITableViewCell *)theTableCell;

+ (void)addBorder:(UIView*)view withWidth:(int)width ;

+ (void)addShadowLayerAtBottom:(UIButton*)button;
/*
 Used to calulate height according to text.
 */
+ (CGFloat)heightForString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width;

+ (void)setButtonLayerPropertiesForTimesheetModuleWithButton:(UIButton *)btn;

@end
