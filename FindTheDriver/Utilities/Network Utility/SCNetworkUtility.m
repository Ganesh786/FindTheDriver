//
//  SCNetworkUtility.m
//  SkillsConnectBusiness
//
//  Created by Dinesh A. Kumar on 6/16/15.
//  Copyright (c) 2015 Endeavour. All rights reserved.
//

#import "SCNetworkUtility.h"
#import "SCNetworkManager.h"
#import "Reachability.h"

@implementation SCNetworkUtility

+ (BOOL)isDeviceNetworkAvailble {
    
    SCNetworkManager *networkManager = [SCNetworkManager sharedNetworkManager];
    return [networkManager isNetworkAvailable];
    
}

@end
