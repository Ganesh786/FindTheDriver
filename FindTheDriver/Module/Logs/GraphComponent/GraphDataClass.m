//
//  GraphDataClass.m
//  FindTheDriver
//
//  Created by mac on 19/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "GraphDataClass.h"

@implementation GraphDataClass

#define kTitle  @"Title"
#define kValue  @"Value"

static NSString *kSectionOFFDuty=@"OFFDuty";
static NSString *kSectionSleeperBirth=@"sleeperBirth";
static NSString *kSectionDriving=@"Driving";
static NSString *kSectionONDuty=@"ONDuty";

+(NSArray*)graphSections{
    return @[kSectionOFFDuty,kSectionSleeperBirth,kSectionDriving,kSectionONDuty];
}

+(NSMutableDictionary*)graphContentDictionary{
    NSMutableDictionary *contents=[[NSMutableDictionary alloc]init];
    
    return contents;
}
@end
