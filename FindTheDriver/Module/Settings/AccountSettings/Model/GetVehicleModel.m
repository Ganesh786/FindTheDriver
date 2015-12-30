//
//  GetVehicleModel.m
//  FindTheDriver
//
//  Created by mac on 16/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "GetVehicleModel.h"

@implementation GetVehicleModel

- (NSMutableDictionary *)toNSDictionary{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    return dict;
}

- (GetVehicleModel *)initWithDictionary:(NSDictionary*)dictionary{
    if (self == [super init]) {
        
    }
    return self;
}

-(void)getVehiclesAPICall:(NSString*)url completionBlock:(GetVehicleModelCompletionBlock)block{
    [[WebServiceInvoker sharedInstance]getToPath:[NSString stringWithFormat:@"%@%@%@",BASE_URL,GET_VEHICLES_URI,url] withParams:nil completion:^(BOOL success, NSString *message, id dataDict) {
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}

@end
