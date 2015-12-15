//
//  ChangePasswordModel.m
//  FindTheDriver
//
//  Created by mac on 15/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "ChangePasswordModel.h"

@implementation ChangePasswordModel

- (NSMutableDictionary *)toNSDictionary{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    return dict;
}
- (ChangePasswordModel *)initWithDictionary:(NSDictionary*)dictionary{
    
    if (self == [super init]) {
    }
    return self;
}


-(void)changePwdAPICall:(NSString*)url completionBlock:(changePasswordModelCompletionBlock)block{
    [[WebServiceInvoker sharedInstance]putToPath:[NSString stringWithFormat:@"%@%@%@",BASE_URL,CHANGE_PASSWORD_URI,url] withParams:nil completion:^(BOOL success, NSString *message, NSDictionary *dataDict) {
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}

@end
