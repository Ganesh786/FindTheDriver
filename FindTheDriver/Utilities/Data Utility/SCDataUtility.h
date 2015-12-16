//
//  SCDataUtility.h
//  SkillsConnectBusiness
//
//  Created by Dinesh A. Kumar on 6/16/15.
//  Copyright (c) 2015 Endeavour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCDataUtility : NSObject

/*!
 * Used to convert the object into dictionary
 * @param obj is any kind of object
 * @return NSMutableDictionary
 */
+ (NSMutableDictionary*)getDictionaryBasaedOnObject:(id)obj;

/*!
 * Used to get the error message based on error Code
 * @param errorCodeStr is NSString Object
 * @return NSString
 */
+ (NSString *)getErrorMessageFromPlistWithErrorCode:(NSString *)errorCodeStr;

//Used to fill data in a model from dictnary.
+ (void)addDataInModel:(id)obj fromDataSource:(NSDictionary*)data;


/*!
 * used to get the Random number
 * @return String Value
 */
+ (NSString *)getRandomNumber;

/*!
 * Used to get the captcha string
 * @param length is an input paramater
 * @return NSString returns a captcha string
 */
+ (NSString *)getCaptchaStringWithLength:(int)length;

//Percent Escapes Using Encoding
+ (NSString*)perEspEncode:(NSString*)data;

+ (NSString *)getShiftStatusFromPlistWithStatusCode:(NSString *)statusCodeStr;

//Get Logged In User Name
+(NSString*)getUserName;

//Get Logged In User Password
+(NSString*)getUserPassword;
@end