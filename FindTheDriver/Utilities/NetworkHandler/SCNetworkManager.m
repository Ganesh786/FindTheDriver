//
//  SCNetworkManager.m
//  SkillsConnect
//
//  Created by Ganesh Korada on 11/11/14.
//
//

#import "SCNetworkManager.h"
#import "Reachability.h"

@interface SCNetworkManager ()
@property (nonatomic, strong) Reachability *reachability;

@end

@implementation SCNetworkManager

static SCNetworkManager *networkManager;

+ (instancetype)sharedNetworkManager {
    
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        networkManager = [[self alloc] init];
    });
    return networkManager;
}

- (instancetype)init {
    
    self = [super init];
    if (self != nil) {
        self.reachability = [Reachability reachabilityForInternetConnection];
        [self.reachability startNotifier];

        // check for internet connection
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(checkNetworkStatus:)
                                                     name:kReachabilityChangedNotification object:nil];

        return self;
    }
    return nil;
}

- (BOOL)isNetworkAvailable {
    BOOL isInternet = NO;
    
    NetworkStatus remoteHostStatus_Second = [self.reachability currentReachabilityStatus];
//    Reachability* reach =[Reachability reachabilityForInternetConnection];
//    NetworkStatus remoteHostStatus = [reach currentReachabilityStatus];

    if(remoteHostStatus_Second == NotReachable)
        isInternet = NO;
    else if (remoteHostStatus_Second == ReachableViaWWAN)
        isInternet = TRUE;
    else if (remoteHostStatus_Second == ReachableViaWiFi)
        isInternet = TRUE;
    return isInternet;
    
    //    if ([self isNetworkReachableViaWiFi] == 0 && [self isInternetAvailable] == 0)
    //        return NO;
    //    else
    //        return YES;
    
}

- (BOOL)isNetworkReachableViaWiFi {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi);
}

- (BOOL)isInternetAvailable {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}


#pragma mark - Internet Online/Offline

/*
    Stop video upload on internet offline mode and 
    start video when internet come from offline to online.
*/

- (void)checkNetworkStatus:(NSNotification *)notice {
    
    NetworkStatus internetStatus = [self.reachability currentReachabilityStatus];
    
    switch (internetStatus) {
            
        case NotReachable:
        {
            break;
        }
        case ReachableViaWiFi:
        case ReachableViaWWAN:
        {

            break;
        }
    }
}


@end
