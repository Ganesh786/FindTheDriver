//
//  LoginModel.m
//  FindTheDriver
//
//  Created by mac on 15/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

- (NSMutableDictionary *)toNSDictionary{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    return dictionary;
}
- (LoginModel *)initWithDictionary:(NSDictionary*)dictionary{
    if (self = [super init]) {

    }
    return self;
}

#pragma mark:-Login API Call
-(void)loginAPICall:(NSString*)url completionBlock:(ServerResponseBlock)block{
    [[WebServiceInvoker sharedInstance]postToPath:[NSString stringWithFormat:@"%@%@%@",BASE_URL,LOGIN_URI,url] withParams:nil completion:^(BOOL success, NSString *message, id dataDict) {
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}

@end
