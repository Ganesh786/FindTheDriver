//
//  RegistrationModel.h
//  FindTheDriver
//
//  Created by mac on 15/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceInvoker.h"
#import "URLConstants.h"

typedef void (^registrationModelCompletionBlock)(BOOL success, NSString *message, NSDictionary *dataDict);

@interface RegistrationModel : NSObject

- (NSMutableDictionary *)toNSDictionary;
- (RegistrationModel *)initWithDictionary:(NSDictionary*)dictionary;

/*!
 * registration API Call
 * @param pass dictionary
 */
-(void)registrationAPICall:(NSMutableDictionary*)params completionBlock:(registrationModelCompletionBlock)block;

@end
