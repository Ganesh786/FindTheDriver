//
//  DocumentZoomViewController.h
//  FindTheDriver
//
//  Created by mac on 26/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentZoomViewController : UIViewController<UIScrollViewDelegate>{
    UIView *containerView;
    UIScrollView *mainScrollView;
    UIImageView *mainImageView;
}

@property(nonatomic,strong)UIImage *zoomImage;
@end
