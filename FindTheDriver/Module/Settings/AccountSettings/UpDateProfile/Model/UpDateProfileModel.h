//
//  UpDateProfileModel.h
//  FindTheDriver
//
//  Created by mac on 18/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceInvoker.h"
#import "URLConstants.h"

typedef void (^UpDateProfileModelCompletionBlock)(BOOL success, NSString *message, id dataDict);

@interface UpDateProfileModel : NSObject

- (NSMutableDictionary *)toNSDictionary;
- (UpDateProfileModel *)initWithDictionary:(NSDictionary*)dictionary;

/*!
 * UpDate Profile API Call
 * @param pass username, password , drivername and Phone Number in url
 */
-(void)upDateProfileAPICall:(NSString*)url params:(NSDictionary*)params completionBlock:(UpDateProfileModelCompletionBlock)block;
@end
