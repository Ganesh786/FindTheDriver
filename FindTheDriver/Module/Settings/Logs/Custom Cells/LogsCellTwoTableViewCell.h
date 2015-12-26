//
//  LogsCellTwoTableViewCell.h
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 11/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogsCellTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *steeringImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIButton *leftToggleBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *leftToggleLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *rightToggleBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *rightToggleLabel;

@end
