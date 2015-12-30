//
//  StartTimeCell.h
//  FindTheDriver
//
//  Created by mac on 24/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;
@property (weak, nonatomic) IBOutlet UIButton *locationBtnOutlet;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIButton *odometerBtnOutlet;
@property (weak, nonatomic) IBOutlet UITextField *odometerTextField;
@property (weak, nonatomic) IBOutlet UILabel *odometerMeasureLabel;

@end
