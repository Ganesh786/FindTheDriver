//
//  SCDataValidation.h
//  SkillsConnectBusiness
//
//  Created by Dinesh A. Kumar on 6/16/15.
//  Copyright (c) 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCDataValidation : NSObject

+ (BOOL)isStringisNull:(NSString*)aString;

/*!
 * Used to test the entered URL is valid or not
 * @param urlString is an NSString
 * @return BOOL
 */
+ (BOOL)isValidURL:(NSString *)urlString;

@end
