//
//  StringConstantsHeader.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 01/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#ifndef StringConstantsHeader_h
#define StringConstantsHeader_h

#import "AppDelegate.h"

//------------------------------- NSUSerDefaults Constants  ----------------------
#define USER_NAME @"USER_NAME"
#define USER_PASSWORD @"USER_PASSWORD"
#define USER_LOGGEDIN @"USER_LOGGEDIN"

// Notification
#define DEVICE_TOKEN @"DeviceToken"
#define NOTIFICATION_STATUS @"NotificationStatus"
#define NOTIFICATION_ALERT @"NotificationAlert"

// Profile Pic
#define PROFILE_PIC @"profilePic"

// Profile Data
#define PROFILE_INFO @"ProfileInfo"

//---------------------------------- Color Constants  ---------------------------
#pragma mark - Color Constants

#define kClearColor                 ([UIColor clearColor])
#define kWhiteColor                 ([UIColor whiteColor])
#define kGrayColor                  ([UIColor grayColor])
#define kOrangeColor                ([UIColor orangeColor])
#define kGreenColor                 ([UIColor greenColor])
#define kLightGrayColor             ([UIColor lightGrayColor])
#define kRedColor                   ([UIColor redColor])
#define kBlueColor                  ([UIColor blueColor])
#define kBlackColor                 ([UIColor blackColor])
#define kNavBarColor                ([UIColor colorFromHexString:@"#1A76CF"])
#define kLayerColor                 ([UIColor colorFromHexString:@"#FF2200"])


//---------------------------------- Font Constants  ---------------------------
#pragma mark - Font Constants

#define kHelveticaNeueFontName          @"HelveticaNeue"
#define kHelveticaNeueBoldFontName      @"HelveticaNeue-Bold"
#define kHelveticaNeueItalicFontName    @"HelveticaNeue-Italic"

//---------------------------------- Log Constants  ---------------------------
#pragma mark - Log Constants


#ifdef DEBUG
#define DEBUGLOG NSLog
#else
#define DEBUGLOG(x,...)
#endif

#define kDeviceOSVersion                ([[UIDevice currentDevice] systemVersion])
#define kDeviceSize                     ([[UIScreen mainScreen] bounds].size)
#define UIAppDelegate                   ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define VALID_STRING(obj) ((obj == (id)[NSNull null]) || ([obj length] == 0 )) ?  @"" : obj
#define VALID_NUMBER(obj) (obj == (id)[NSNull null]) ?                            @0 : obj
#define VALID_INT(obj) ([obj isKindOfClass: [NSNull class]]) ?   @0 : obj
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO

//---------------------------------- Storyboard Constants  ---------------------------
#pragma mark - Storyboard Constants

#define kLoginStoryboard               ([UIStoryboard storyboardWithName:@"Login" bundle: [NSBundle mainBundle]])
#define kHomeStoryboard                ([UIStoryboard storyboardWithName:@"HomeStoryboard" bundle: [NSBundle mainBundle]])
#define kLogsStoryboard                ([UIStoryboard storyboardWithName:@"LogsStoryboard" bundle: [NSBundle mainBundle]])
#define kSettingsStoryboard            ([UIStoryboard storyboardWithName:@"SettingsStoryboard" bundle: [NSBundle mainBundle]])


#define kComingSoon     @"Coming Soon"
#define ACCEPTABLE_CHARECTERS @"0123456789"
#define PHONE_NUMBER_LIMIT 25

#endif /* StringConstantsHeader_h */
