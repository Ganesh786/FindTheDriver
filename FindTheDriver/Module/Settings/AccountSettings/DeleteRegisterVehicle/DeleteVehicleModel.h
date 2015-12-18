//
//  DeleteVehicleModel.h
//  FindTheDriver
//
//  Created by mac on 18/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceInvoker.h"
#import "URLConstants.h"

typedef void (^DeleteVehicleModelCompletionBlock)(BOOL success, NSString *message, id dataDict);

@interface DeleteVehicleModel : NSObject

- (NSMutableDictionary *)toNSDictionary;
- (DeleteVehicleModel *)initWithDictionary:(NSDictionary*)dictionary;

/*!
 * Delete Vehicle API Call
 * @param pass username and password in url
 * @param pass vehicles details in body
 */
-(void)deleteVehicleAPICall:(NSString*)url params:(NSDictionary*)params completionBlock:(DeleteVehicleModelCompletionBlock)block;

@end
