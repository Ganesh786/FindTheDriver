//
//  CurrentLocation.h
//  Admizz
//
//  Created by mac on 16/12/15.
//  Copyright © 2015 DGTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationFinderDelegate <NSObject>
@required
-(void)update:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@end

@interface CurrentLocation : NSObject<CLLocationManagerDelegate>

@property (nonatomic ,retain)CLLocationManager *locationManager;
@property (nonatomic ,retain)id delegate;

@end