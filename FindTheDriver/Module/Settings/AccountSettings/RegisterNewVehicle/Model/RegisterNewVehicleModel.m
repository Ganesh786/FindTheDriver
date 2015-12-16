//
//  RegisterNewVehicleModel.m
//  FindTheDriver
//
//  Created by mac on 16/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "RegisterNewVehicleModel.h"

@implementation RegisterNewVehicleModel

- (NSMutableDictionary *)toNSDictionary{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    return dict;
}

- (RegisterNewVehicleModel *)initWithDictionary:(NSDictionary*)dictionary{
    if (self == [super init]) {
        
        
    }
    return self;
}

-(void)newVehicleAPICall:(NSString*)url params:(NSDictionary*)params completionBlock:(RegisterNewVehicleModelCompletionBlock)block{
    [[WebServiceInvoker sharedInstance]postToPath:[NSString stringWithFormat:@"%@%@%@",BASE_URL,ADD_NEW_VEHICLE_URI,url] withParams:params completion:^(BOOL success, NSString *message, NSDictionary *dataDict) {
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}
@end
