//
//  DeleteVehicleModel.m
//  FindTheDriver
//
//  Created by mac on 18/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "DeleteVehicleModel.h"

@implementation DeleteVehicleModel

- (NSMutableDictionary *)toNSDictionary{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    return dict;
}
- (DeleteVehicleModel *)initWithDictionary:(NSDictionary*)dictionary{
    if (self == [super init]) {
    }
    return self;
}

-(void)deleteVehicleAPICall:(NSString*)url params:(NSDictionary*)params completionBlock:(DeleteVehicleModelCompletionBlock)block{
    [[WebServiceInvoker sharedInstance]deleteToPath:[NSString stringWithFormat:@"%@%@%@",BASE_URL,DELETE_VEHICLE_URI,url] withParams:params completion:^(BOOL success, NSString *message, id dataDict){
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}
@end
