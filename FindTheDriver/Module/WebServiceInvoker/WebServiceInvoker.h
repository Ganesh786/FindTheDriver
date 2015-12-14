//
//  WebServiceInvoker.h
//  WebServiceModule
//
//  Created by Sandeep Lall on 14/12/15.
//  Copyright © 2015 Shreeshail S Ganachari. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "URLConstants.h"

typedef void (^ServerResponseBlock)(BOOL success, NSString *message, NSDictionary *dataDict);

@interface WebServiceInvoker : AFHTTPRequestOperationManager

+(WebServiceInvoker*)sharedInstance;

-(void)loginAPICall:(NSString*)url completionBlock:(ServerResponseBlock)block;

@end
