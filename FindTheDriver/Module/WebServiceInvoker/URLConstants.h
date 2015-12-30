//
//  URLConstants.h
//  WebServiceModule
//
//  Created by Sandeep Lall on 14/12/15.
//  Copyright © 2015 Shreeshail S Ganachari. All rights reserved.
//

#ifndef URLConstants_h
#define URLConstants_h

//------------------------ URL's------------------
#define BASE_URL @"http://121.244.199.9:9090/"

#define LOGIN_URI @"api/V1/LogIn/"
#define REGISTRATION_URI @"api/V1/Registration"
#define ACTIVATION_URI @"api/V1/Activation/"
#define PASSWORD_RESET_URI @"api/V1/PasswordReset/"
#define CHANGE_PASSWORD_URI @"api/V1/ChangePassword/"
#define UPDATE_PROFILE_URI @"api/V1/Profile/"
#define GET_VEHICLES_URI @"api/V1/Vehicles/"
#define ADD_NEW_VEHICLE_URI @"api/V1/Vehicle/"
#define DELETE_VEHICLE_URI @"api/V1/Vehicle/"

//------------------------- Network Error Message --------------
#define NETWORK_ERROR_TITLE @"Network Error"
#define NETWORK_ERROR_MESSAGE @"Please check you network connection!"
#define NETWORK_RESPONSE_ERROR_MESSAGE @"Something went wrong, please try again after some time"

#endif /* URLConstants_h */
