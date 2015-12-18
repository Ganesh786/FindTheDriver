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
        NSString *message = NETWORK_RESPONSE_ERROR_MESSAGE;
        BOOL success = NO;
        if (![responseObject isKindOfClass:[NSNull class]]) {
            success =YES;
            message = @"Success";
        }
        if (block) {
            block(success, message, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(NO, error.description, nil);
        }
    }];
}
- (void)getToPath:(NSString*)path withParams:(NSDictionary*)params completion:(ServerResponseBlock)block{
    if (![AFNetworkReachabilityManager sharedManager].reachable){
        block(NO,NETWORK_ERROR_MESSAGE,nil);
        return;
    }
    [self GET:path parameters:params  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![NSThread isMainThread]) {
            abort();
        }
        NSString *message = NETWORK_RESPONSE_ERROR_MESSAGE;
        BOOL success = NO;
        if (![responseObject isKindOfClass:[NSNull class]]) {
            success =YES;
            message = @"Success";
        }
        if (block) {
            block(success, message, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(NO, error.description, nil);
        }
        
    }];
}

- (void)putToPath:(NSString*)path withParams:(NSDictionary*)params completion:(ServerResponseBlock)block{
    if (![AFNetworkReachabilityManager sharedManager].reachable){
        block(NO,NETWORK_ERROR_MESSAGE,nil);
        return;
    }
    [self PUT:path parameters:params  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![NSThread isMainThread]) {
            abort();
        }
        NSString *message = NETWORK_RESPONSE_ERROR_MESSAGE;
        BOOL success = NO;
        if (![responseObject isKindOfClass:[NSNull class]]) {
            success =YES;
            message = @"Success";
        }
        if (block) {
            block(success, message, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(NO, error.description, nil);
        }
        
    }];
}

- (void)deleteToPath:(NSString*)path withParams:(NSDictionary*)params completion:(ServerResponseBlock)block{
    if (![AFNetworkReachabilityManager sharedManager].reachable){
        block(NO,NETWORK_ERROR_MESSAGE,nil);
        return;
    }
    [self DELETE:path parameters:params  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![NSThread isMainThread]) {
            abort();
        }
        NSString *message = NETWORK_RESPONSE_ERROR_MESSAGE;
        BOOL success = NO;
        if (![responseObject isKindOfClass:[NSNull class]]) {
            success =YES;
            message = @"Success";
        }
        if (block) {
            block(success, message, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(NO, error.description, nil);
        }
        
    }];
}

@end
