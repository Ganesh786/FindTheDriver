//
//  SCDataUtility.m
//  SkillsConnectBusiness
//
//  Created by Dinesh A. Kumar on 6/16/15.
//  Copyright (c) 2015 Endeavour. All rights reserved.
//

#import "SCDataUtility.h"
#import <objc/runtime.h>

@implementation SCDataUtility

+ (NSMutableArray *)getAllKeysOfObj:(id)obj {
    NSMutableArray *keysArr = [NSMutableArray array];
    unsigned int count=0;
    objc_property_t *props = class_copyPropertyList([obj class],&count);
    for (int i=0; i<count; i++) {
        const char *name = property_getName(props[i]);
        NSString *keyStr = [NSString stringWithFormat:@"%s",name];
        [keysArr addObject:keyStr];
    }
    return keysArr;
}

+ (NSMutableDictionary*)getDictionaryBasaedOnObject:(id)obj {
    NSArray *keysArray = [self getAllKeysOfObj:obj];
    NSMutableArray *valuesArray = [NSMutableArray array];
    for (NSString *propKey in keysArray) {
        if ([obj valueForKey:propKey]!=nil)
            [valuesArray addObject:[obj valueForKey:propKey]];
        else
            [valuesArray addObject:[NSNull null]];
    }
    NSMutableDictionary *registerDict = [[NSMutableDictionary alloc]initWithObjects:valuesArray forKeys:keysArray];
    return registerDict;
}

#pragma mark - DTO Binding
+ (void)addDataInModel:(id)obj fromDataSource:(NSDictionary*)data {
    NSMutableArray *keys = [self getAllKeysOfObj:obj];
    for (NSString *key in keys)
        [obj setValue:data[key] forKey:key];
}


+ (NSString *)getRandomNumber {
    NSString *min = @"1000";
    NSString *max = @"9999";
    int randNum = rand() % (max.intValue - min.intValue) + min.intValue;
    return [NSString stringWithFormat:@"%d", randNum];
}

+ (NSString *)getCaptchaStringWithLength:(int)length {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (int i=0; i<length; i++)
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)letters.length)]];
    return randomString;
}

+ (NSString*)perEspEncode:(NSString*)data {
    return [data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)getErrorMessageFromPlistWithErrorCode:(NSString *)errorCodeStr {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SCErrorCodePList" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    return NSLocalizedString(dict[errorCodeStr], nil);
}

+ (NSString *)getShiftStatusFromPlistWithStatusCode:(NSString *)statusCodeStr {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SCShiftStatuses" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    return NSLocalizedString(dict[statusCodeStr], nil);
}

+(NSString*)getTodayDate:(NSString*)formatter{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:formatter];
    NSDate *date = [NSDate date];
    NSString *newDate = [formater stringFromDate:date];
    return newDate;
}

+(NSString*)getUserName{
    return [[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME];
}

+(NSString*)getUserPassword{
    return [[NSUserDefaults standardUserDefaults]objectForKey:USER_PASSWORD];
}

+(NSString*)getAppVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+(NSString*)getDeviceToken{
    return [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_TOKEN];
}

+(BOOL)getNotificationStatus{
    return [[NSUserDefaults standardUserDefaults]boolForKey:NOTIFICATION_STATUS];
}

+(void)setNotificationStatus:(BOOL)status{
  [[NSUserDefaults standardUserDefaults]setBool:status forKey:NOTIFICATION_STATUS];
  [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSString*)getHOSNotificationAlertType{
    return [[NSUserDefaults standardUserDefaults]objectForKey:NOTIFICATION_ALERT];
}
+(void)setHOSNotificationAlertType:(NSString*)alertType{
    [[NSUserDefaults standardUserDefaults]setObject:alertType forKey:NOTIFICATION_ALERT];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
