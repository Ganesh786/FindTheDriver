//
//  SCNetworkManager.h
//  SkillsConnect
//
//  Created by Ganesh Korada on 11/11/14.
//
//

#import <Foundation/Foundation.h>

@interface SCNetworkManager : NSObject

/*!
 * @method      sharedNetworkManager
 * @discussion  Used to get the shared instance
 * @return      SCNetworkManager
 */
+ (instancetype)sharedNetworkManager;

/*!
 * @method      isNetworkAvailable
 * @discussion  Used to check the network is availble or not
 * @return      BOOL
 */
- (BOOL)isNetworkAvailable;

@end
