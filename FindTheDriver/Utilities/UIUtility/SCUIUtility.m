//
//  SCUIUtility.m
//  SkillsConnectBusiness
//
//  Created by Dinesh A. Kumar on 6/16/15.
//  Copyright (c) 2015 Endeavour. All rights reserved.
//

#import "SCUIUtility.h"
#import <CoreText/CoreText.h>

#define kBatchLoadingTag 9988

@implementation SCUIUtility

#pragma mark - Batch Loading


+ (void)setAttributesForTextField:(UITextField *)txtFld
              WithPlaceholderText:(NSString *)txt
                    WithTextColor:(UIColor *)color {
    
    txtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txt attributes: @{NSForegroundColorAttributeName: color, NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:14]}];
}

+ (void)setLeftViewForTheTextField:(UITextField *)txtFld WithImage:(UIImage *)img {
    UIImageView *mailImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 22, 22)];
    mailImgView.image = img;
    
    UIView *mailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [mailPaddingView addSubview:mailImgView];
    txtFld.leftViewMode = UITextFieldViewModeAlways;
    txtFld.leftView = mailPaddingView;
}

+ (void)setUnderlineForTheButton:(UIButton *)btn {
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
    
    [commentString addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:NSMakeRange(0, commentString.length-2)];
    
    [btn setAttributedTitle:commentString forState:UIControlStateNormal];
}

+ (UILabel *)getNoResultsLabelWithFrame:(CGRect)frame WithText:(NSString *)textStr {
    UILabel *noSearchResultsLbl = [[UILabel alloc]initWithFrame:frame];
    noSearchResultsLbl.numberOfLines=0;
    noSearchResultsLbl.lineBreakMode=NSLineBreakByWordWrapping;
    noSearchResultsLbl.text = textStr;
    noSearchResultsLbl.textAlignment=NSTextAlignmentCenter;
    noSearchResultsLbl.textColor=kLightGrayColor;
    noSearchResultsLbl.font = [UIFont fontWithName:kHelveticaNeueFontName size:17];
    return noSearchResultsLbl;
}

+ (UIView *)getCustomBackButton {
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(-5, 0, 60, 30)];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 5, 12, 20)];
    backImage.image = [UIImage imageNamed:@"Back"];
    [backButtonView addSubview:backImage];
    
    UILabel *backLbl = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 50, 30)];
    backLbl.text = @"Back";
    backLbl.textColor = kWhiteColor;
    backLbl.font = [UIFont fontWithName:kHelveticaNeueFontName size:17];
    [backButtonView addSubview:backLbl];
    
    return backButtonView;
}

+ (void)setBarButtonAppearanceWithColor:(UIColor *)color {
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes: @{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont fontWithName:kHelveticaNeueFontName size:17] } forState:UIControlStateNormal];
}

+ (void)setLayerForView:(UIView *)view WithColor:(UIColor *)color {
    view.layer.cornerRadius = 7;
    view.layer.borderWidth = 1;
    view.layer.borderColor = color.CGColor;
}

+ (NSAttributedString *)addStarAtEndOfString:(NSString*)labelStr WithColor:(UIColor *)color {
    NSString *label=[NSString stringWithFormat:@"%@ *",labelStr];
    
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc]initWithString:label];
    [attributedStr beginEditing];
    [attributedStr addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(label.length-1, 1)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(label.length-1, 1)];
    [attributedStr endEditing];
    
    return attributedStr;
}

+ (void)addShadowEffectForTheButton:(UIButton *)sender {
    UIButton *btn = sender;
    btn.layer.cornerRadius = 2.0f;
    btn.layer.masksToBounds = NO;
    btn.layer.shadowColor = [UIColor colorFromHexString:@"#E96E2F"].CGColor;
}


+ (void)removeCellSeparatorInsetForCell:(UITableViewCell *)theTableCell {
    // Remove seperator inset
    if ([theTableCell respondsToSelector:@selector(setSeparatorInset:)])
        theTableCell.separatorInset = UIEdgeInsetsZero;
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([theTableCell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        [theTableCell setPreservesSuperviewLayoutMargins:NO];
    
    // Explictly set your cell's layout margins
    if ([theTableCell respondsToSelector:@selector(setLayoutMargins:)])
        theTableCell.layoutMargins = UIEdgeInsetsZero;
}

#pragma  mark - Add Border

+ (void)addBorder:(UIView*)view withWidth:(int)width {
    view.layer.cornerRadius = width/2;
    view.layer.borderColor = kLightGrayColor.CGColor;
    view.layer.borderWidth = 2.0f;
    view.layer.masksToBounds = YES;
}

#pragma mark - Shadow Layer

+ (void)addShadowLayerAtBottom:(UIButton*)button {
    button.imageView.layer.cornerRadius = 0.0f;
    button.layer.shadowRadius = 1.0f;
    UIColor *layerCol = kLayerColor;
    button.layer.shadowColor = layerCol.CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.layer.shadowOpacity = 1.0f;
    button.layer.masksToBounds = NO;
}

+ (void)setButtonLayerPropertiesForTimesheetModuleWithButton:(UIButton *)btn {
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = kWhiteColor.CGColor;
    btn.layer.cornerRadius = 7.0;
}

#pragma mark - Calculate Height

+ (CGFloat)heightForString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width {
    if (text.length) {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
        return rect.size.height;
    }
    else
        return 0;
}

#pragma mark:- email validation
+(BOOL)validateEmailWithString:(NSString *)email{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([emailTest evaluateWithObject:email] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark:- phone number validation
+(BOOL)validateMobileNumber:(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}

#pragma mark:- validate String
+(NSString*)validateString:(NSString*)str{
    NSString *trimedstr  = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(trimedstr == (id)[NSNull null] || [trimedstr isEqualToString:@""] || [trimedstr isKindOfClass:[NSNull class]])
    {
            trimedstr=@"";
    }
    return trimedstr;
}
@end