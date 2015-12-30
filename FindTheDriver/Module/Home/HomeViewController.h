//
//  HomeViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 02/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "CustomHomeActionViewController.h"
#import "CurrentLocation.h"

@interface HomeViewController : UIViewController<CustomHomeActionViewControllerDelegate,CoreLocationFinderDelegate>{
    CLGeocoder *geoCoder;
    CLPlacemark *placemark;
    NSString *currentPlace;
    NSString *currentLatitude;
    NSString *currentLongitude;

}
@property(nonatomic,retain)CurrentLocation *locationFinder;

@property(nonatomic, retain) IBOutlet CustomHomeActionViewController *customHomeActionViewController;

@end
