//
//  TodayLogDetailStatusTableViewCell.h
//  FindTheDriver
//
//  Created by mac on 20/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayLogDetailStatusTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *offDutyBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *offDutyLabel;
@property (weak, nonatomic) IBOutlet UIButton *sleeperBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *sleeperLabel;
@property (weak, nonatomic) IBOutlet UIButton *drivingBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *drivingLabel;
@property (weak, nonatomic) IBOutlet UIButton *onDutyBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *onDutyLabel;

@end
