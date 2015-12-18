//
//  UpDateProfileModel.m
//  FindTheDriver
//
//  Created by mac on 18/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "UpDateProfileModel.h"

@implementation UpDateProfileModel

- (NSMutableDictionary *)toNSDictionary{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    return dict;
}
- (UpDateProfileModel *)initWithDictionary:(NSDictionary*)dictionary{
    if (self == [super init]) {
        
        
    }
    return self;
}


-(void)upDateProfileAPICall:(NSString*)url params:(NSDictionary*)params completionBlock:(UpDateProfileModelCompletionBlock)block{
    [[WebServiceInvoker sharedInstance]putToPath:[NSString stringWithFormat:@"%@%@%@",BASE_URL,UPDATE_PROFILE_URI,url] withParams:params completion:^(BOOL success, NSString *message, id dataDict){
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}

@end
