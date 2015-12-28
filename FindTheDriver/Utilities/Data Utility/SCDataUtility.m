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

//Get Today Date for Dash Board
+(NSString*)getTodayDateForDashBoard{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"EEEE MM, LLL"];
    NSDate *date = [NSDate date];
    NSString *newDate = [formater stringFromDate:date];
    return newDate;
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

#pragma mark:- Gallery Image Methods
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    CGFloat widthRatio = newSize.width/image.size.width;
    CGFloat heightRatio = newSize.height/image.size.height;
    if(widthRatio > heightRatio)
    {
        newSize=CGSizeMake(image.size.width*heightRatio,image.size.height*heightRatio);
    }
    else
    {
        newSize=CGSizeMake(image.size.width*widthRatio,image.size.height*widthRatio);
    }
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+(void)deleteGalleryImage{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *gallery = [paths objectAtIndex:0];
    NSString *dataPath = [gallery stringByAppendingPathComponent:@"/aFindTheDriverImage"];
    NSError *error = NULL;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:dataPath]){
        BOOL success = [filemgr removeItemAtPath:dataPath error:&error];
        if (success) {
        }
        else
        {
        }
    }
}

+(void)writeGalleryImage:(UIImage*)image imagename:(NSString*)imagename{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *gallery = [paths objectAtIndex:0];
    NSString *dataPath = [gallery stringByAppendingPathComponent:@"/aFindTheDriverImage"];
    NSError *error = NULL;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if (![filemgr fileExistsAtPath:dataPath])
        [filemgr createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    NSString *savedGalleryImagePath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imagename]];
    NSData *galleryImageData=UIImagePNGRepresentation(image);
    [galleryImageData writeToFile:savedGalleryImagePath atomically:YES];
}

+(UIImage*)galleryImage:(NSString*)imageName{
    UIImage *image=[[UIImage alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *gallery = [paths objectAtIndex:0];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSString *dataPath = [gallery stringByAppendingPathComponent:@"/aFindTheDriverImage"];
    NSError *error;
    NSArray *filelist= [filemgr contentsOfDirectoryAtPath:dataPath error:&error];
    if ([filelist containsObject:[NSString stringWithFormat:@"%@.png",imageName]]) {
        NSString *getImagePath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
        image=[UIImage imageWithContentsOfFile:getImagePath];
    }else{
        image=[UIImage imageNamed:@"profilePIC"];
    }
    return image;
}

//Store Profile Info
+(void)storeDriverInfo:(id)profileInfoDict{
    [[NSUserDefaults standardUserDefaults]setObject:profileInfoDict forKey:PROFILE_INFO];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(id)getProfileInfoDict{
   return [[NSUserDefaults standardUserDefaults]dictionaryForKey:PROFILE_INFO];
}

//Store Duty Cycle
+(void)storeDutyCycle:(id)dutyCycleDict{
    [[NSUserDefaults standardUserDefaults]setObject:dutyCycleDict forKey:DUTY_CYCLE];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(id)getDutyCycleDict{
    return [[NSUserDefaults standardUserDefaults]dictionaryForKey:DUTY_CYCLE];
}

//Store Time Zone
+(void)storeTimeZone:(id)timeZoneDict{
    [[NSUserDefaults standardUserDefaults]setObject:timeZoneDict forKey:TIME_ZONE];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(id)getTimeZoneDict{
    return [[NSUserDefaults standardUserDefaults]dictionaryForKey:TIME_ZONE];
}

//Store Carrier
+(void)storeCarrier:(id)dataDict{
    [[NSUserDefaults standardUserDefaults]setObject:dataDict forKey:CARRIER];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(id)getStoreCarrierData{
    return [[NSUserDefaults standardUserDefaults]dictionaryForKey:CARRIER];
}

//Store Exceptions
+(void)storeExceptions:(id)dataDict{
    [[NSUserDefaults standardUserDefaults]setObject:dataDict forKey:EXCEPTIONS];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(id)getExceptionsData{
    return [[NSUserDefaults standardUserDefaults]dictionaryForKey:EXCEPTIONS];
}

//Store HosStatus
+(void)storeHosStatus:(id)dataDict{
    [[NSUserDefaults standardUserDefaults]setObject:dataDict forKey:HOS_STATUS];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(id)getHosStatusData{
    return [[NSUserDefaults standardUserDefaults]dictionaryForKey:HOS_STATUS];
}

//Store VIRDefects
+(void)storeVIRDefects:(id)dataDict{
    [[NSUserDefaults standardUserDefaults]setObject:dataDict forKey:VIR_DEFECTS];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(id)getVIRDefectsData{
    return [[NSUserDefaults standardUserDefaults]dictionaryForKey:VIR_DEFECTS];
}

//Store Violations
+(void)storeViolations:(id)dataDict{
    [[NSUserDefaults standardUserDefaults]setObject:dataDict forKey:VIOLATIONS];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(id)getViolationsData{
    return [[NSUserDefaults standardUserDefaults]dictionaryForKey:VIOLATIONS];
}

//Store Settings Logs
+(void)storeSelectedTimeZone:(NSString*)str{
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"SelectedTimeZone"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSString*)getSelectedTimeZone{
    NSString *str=[self validateString:[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedTimeZone"]];
    if (str.length<=0) {
        NSArray *arr=[[self getTimeZoneDict] objectForKey:TIME_ZONE];
        if (arr.count>0) {
            str=[[arr objectAtIndex:0]objectForKey:@"TimeZoneId"];
        }
    }
    return str;
}

+(void)storeSelectedCycle:(NSString*)str{
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"SelectedCycle"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSString*)getSelectedCycle{
    NSString *str=[self validateString:[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedCycle"]];
    if (str.length<=0) {
        NSArray *arr=[[self getDutyCycleDict] objectForKey:DUTY_CYCLE];
        if (arr.count>0) {
            str=[[arr objectAtIndex:0]objectForKey:@"CycleCode"];
        }
    }
    return str;
}

+(void)storeSelectedOdoMeter:(NSString*)str{
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"SelectedOdometer"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSString*)getSelectedOdometer{
    NSString *str=[self validateString:[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedOdometer"]];
    if (str.length<=0) {
        str=@"KiloMeters";
    }
    return str;
}

+(void)storeSelectedLogIncrement:(NSString*)str{
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"SelectedLogIncrement"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSString*)getSelectedLogIncrement{
    NSString *str=[self validateString:[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedLogIncrement"]];
    if (str.length<=0) {
        str=@"1 Minute";
    }
    return str;
}

#pragma mark:- validate String
+(NSString*)validateString:(NSString*)str{
    NSString *trimedstr  = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(trimedstr == (id)[NSNull null] || [trimedstr isEqualToString:@""] || [trimedstr isKindOfClass:[NSNull class]])
    {
        trimedstr=@"";
    }
    return trimedstr;
}
@end
