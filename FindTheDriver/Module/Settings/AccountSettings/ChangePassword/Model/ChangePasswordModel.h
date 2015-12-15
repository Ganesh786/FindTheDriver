//
//  ChangePasswordModel.h
//  FindTheDriver
//
//  Created by mac on 15/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceInvoker.h"
#import "URLConstants.h"

typedef void (^changePasswordModelCompletionBlock)(BOOL success, NSString *message, NSDictionary *dataDict);

@interface ChangePasswordModel : NSObject

- (NSMutableDictionary *)toNSDictionary;
- (ChangePasswordModel *)initWithDictionary:(NSDictionary*)dictionary;

/*!
 * Change Password API Call
 * @param pass username password and new password in url
 */
-(void)changePwdAPICall:(NSString*)url completionBlock:(changePasswordModelCompletionBlock)block;

@end
