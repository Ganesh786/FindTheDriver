//
//  LogFormViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddDocumentView.h"
#import "DeleteDocumentView.h"
#import "CurrentLocation.h"

@interface LogFormViewController : UIViewController<AddDocumentViewProtocol,DeleteDocumentViewProtocol,CoreLocationFinderDelegate>{
    CLGeocoder *geoCoder;
    CLPlacemark *placemark;
}
@property(nonatomic,retain)CurrentLocation *locationFinder;

@end
