//
//  CurrentLocation.m
//  Admizz
//
//  Created by mac on 16/12/15.
//  Copyright © 2015 DGTech. All rights reserved.
//

#import "CurrentLocation.h"

@implementation CurrentLocation
-(id)init{
    self = [super init];
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestWhenInUseAuthorization];
        self.locationManager.delegate = self;
    }
    return self;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [self.delegate update:[locations lastObject]];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self.delegate locationError:error];
}

@end
