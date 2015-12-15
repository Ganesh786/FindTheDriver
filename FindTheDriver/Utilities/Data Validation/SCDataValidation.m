//
//  SCDataValidation.m
//  SkillsConnectBusiness
//
//  Created by Dinesh A. Kumar on 6/16/15.
//  Copyright (c) 2015 Endeavour. All rights reserved.
//

#import "SCDataValidation.h"

@implementation SCDataValidation

+ (BOOL)isStringisNull:(NSString*)aString {
    if([aString class]==[NSNull class])
        return YES;
    return NO;
}

+ (BOOL)isValidURL:(NSString *)urlString {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:urlString];
}

@end
