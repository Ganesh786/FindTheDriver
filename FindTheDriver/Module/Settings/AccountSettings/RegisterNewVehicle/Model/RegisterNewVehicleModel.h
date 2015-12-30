//
//  RegisterNewVehicleModel.h
//  FindTheDriver
//
//  Created by mac on 16/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceInvoker.h"
#import "URLConstants.h"

typedef void (^RegisterNewVehicleModelCompletionBlock)(BOOL success, NSString *message, id dataDict);

@interface RegisterNewVehicleModel : NSObject

- (NSMutableDictionary *)toNSDictionary;
- (RegisterNewVehicleModel *)initWithDictionary:(NSDictionary*)dictionary;

/*!
 * New Vehicle API Call
 * @param pass username and password in url
 *Pass params in body
 */
-(void)newVehicleAPICall:(NSString*)url params:(NSDictionary*)params completionBlock:(RegisterNewVehicleModelCompletionBlock)block;
@end
