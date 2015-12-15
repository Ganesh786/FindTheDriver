//
//  LoginModel.h
//  FindTheDriver
//
//  Created by mac on 15/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceInvoker.h"
#import "URLConstants.h"

typedef void (^loginModelCompletionBlock)(BOOL success, NSString *message, NSDictionary *dataDict);

@interface LoginModel : NSObject

- (NSMutableDictionary *)toNSDictionary;
- (LoginModel *)initWithDictionary:(NSDictionary*)dictionary;

/*!
 * Login API Call
 * @param pass username and password in url
 */
-(void)loginAPICall:(NSString*)url completionBlock:(loginModelCompletionBlock)block;
@end
