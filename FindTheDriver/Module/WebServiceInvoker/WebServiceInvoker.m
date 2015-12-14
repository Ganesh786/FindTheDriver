//
//  WebServiceInvoker.m
//  WebServiceModule
//
//  Created by Sandeep Lall on 14/12/15.
//  Copyright © 2015 Shreeshail S Ganachari. All rights reserved.
//

#import "WebServiceInvoker.h"

@implementation WebServiceInvoker


+ (WebServiceInvoker *)sharedInstance
{
    static WebServiceInvoker *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WebServiceInvoker alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [self.requestSerializer setAuthorizationHeaderFieldWithUsername:AUTH_USERNAME password:AUTH_PASSWORD];
        self.requestSerializer.timeoutInterval = 60.0f;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    
    return self;
}

-(void)cancel{
    @synchronized(self){
        self.requestSerializer = nil;
        self.responseSerializer = nil;
    }
}

-(instancetype)init{
    if (self= [super init]) {
    }
    return self;
}

#pragma mark - Service Post method

- (void)postToPath:(NSString*)path withParams:(NSDictionary*)params completion:(ServerResponseBlock)block{
    if (![AFNetworkReachabilityManager sharedManager].reachable){
        block(NO,NETWORK_ERROR_MESSAGE,nil);
        return;
    }
    [self POST:path parameters:params  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![NSThread isMainThread]) {
            abort();
        }
        NSString *message = nil;
        BOOL success = NO;
        NSDictionary *dict = nil;
        
        if (!responseObject) {
            message = @"Returned no data";
        } else  {
            if ([responseObject isKindOfClass:[NSArray class]]) {
                block(NO,@"No results found",nil);
                return;
            }
            NSDictionary *contentDict = (NSDictionary*)responseObject;
            if (!contentDict) {
                message = @"Invalid Response";
            } else {
                success = (operation.response.statusCode == 200);
            }
            message = [contentDict valueForKey:@"message"];
            dict = contentDict;
        }
        if (block) {
            block(success, message, dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(NO, error.description, nil);
        }
        
    }];
}


-(void)loginAPICall:(NSString*)url completionBlock:(ServerResponseBlock)block{
    [self postToPath:[NSString stringWithFormat:@"%@%@%@",BASE_URL,LOGIN_URI,url] withParams:nil completion:^(BOOL success, NSString *message, NSDictionary *dataDict) {
        if (success) {
            //Update DB
        }
        block(success,message,dataDict);
    }];
}

@end
