//
//  GetVehicleModel.h
//  FindTheDriver
//
//  Created by mac on 16/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceInvoker.h"
#import "URLConstants.h"

typedef void (^GetVehicleModelCompletionBlock)(BOOL success, NSString *message, id dataDict);

@interface GetVehicleModel : NSObject

- (NSMutableDictionary *)toNSDictionary;
- (GetVehicleModel *)initWithDictionary:(NSDictionary*)dictionary;

/*!
 * Get Vehicles API Call
 * @param pass username and password in url
 */
-(void)getVehiclesAPICall:(NSString*)url completionBlock:(GetVehicleModelCompletionBlock)block;
@end
