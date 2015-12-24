//
//  PasswordResetModel.m
//  FindTheDriver
//
//  Created by mac on 24/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "PasswordResetModel.h"

@implementation PasswordResetModel

- (NSMutableDictionary *)toNSDictionary{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    return dictionary;
}
- (PasswordResetModel *)initWithDictionary:(NSDictionary*)dictionary{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark:-Login API Call
-(void)passwordResetAPICall:(NSString*)url completionBlock:(passwordResetModelCompletionBlock)block{
    [[WebServiceInvoker sharedInstance]putToPath:[NSString stringWithFormat:@"%@%@%@",BASE_URL,PASSWORD_RESET_URI,url] withParams:nil completion:^(BOOL success, NSString *message, id dataDict) {
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}

@end
