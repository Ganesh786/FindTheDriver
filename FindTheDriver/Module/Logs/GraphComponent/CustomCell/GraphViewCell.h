//
//  GraphViewCell.h
//  FindTheDriver
//
//  Created by mac on 19/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewCell : UICollectionViewCell

@property(strong,nonatomic)CALayer *rightTopBorder;
@property(strong,nonatomic)CALayer *rightBottomBorder;
@property(strong,nonatomic)UIView *gridHorView;

@end
