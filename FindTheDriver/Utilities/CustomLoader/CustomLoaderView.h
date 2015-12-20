//
//  CustomLoaderView.h
//  FindTheDriver
//
//  Created by mac on 20/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLoaderView : UIView
- (id)initWithFrame:(CGRect)frame loaderHt:(NSInteger)loaderHt;
+(CustomLoaderView*)sharedView;
-(void)showLoader;
-(void)dismissLoader;
@end
