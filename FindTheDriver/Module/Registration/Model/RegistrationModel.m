//
//  RegistrationModel.m
//  FindTheDriver
//
//  Created by mac on 15/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "RegistrationModel.h"

@implementation RegistrationModel

- (NSMutableDictionary *)toNSDictionary{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    return dictionary;
}

- (RegistrationModel *)initWithDictionary:(NSDictionary*)dictionary{
    
    if (self = [super init]) {
        
        
    }
    return self;
}

#pragma mark:-Registration API Call
-(void)registrationAPICall:(NSMutableDictionary*)params completionBlock:(ServerResponseBlock)block{
    [[WebServiceInvoker sharedInstance]postToPath:[NSString stringWithFormat:@"%@%@",BASE_URL,REGISTRATION_URI] withParams:params completion:^(BOOL success, NSString *message, id dataDict) {
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}


@end
