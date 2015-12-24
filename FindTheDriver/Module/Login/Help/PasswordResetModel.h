//
//  PasswordResetModel.h
//  FindTheDriver
//
//  Created by mac on 24/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceInvoker.h"
#import "URLConstants.h"

typedef void (^passwordResetModelCompletionBlock)(BOOL success, NSString *message, id dataDict);

@interface PasswordResetModel : NSObject

- (NSMutableDictionary *)toNSDictionary;
- (PasswordResetModel *)initWithDictionary:(NSDictionary*)dictionary;

/*!
 * Password Reset API Call
 * @param pass username and password in url
 */
-(void)passwordResetAPICall:(NSString*)url completionBlock:(passwordResetModelCompletionBlock)block;
@end
