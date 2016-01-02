//
//  InspectLogSignatureCell.h
//  FindTheDriver
//
//  Created by mac on 02/01/16.
//  Copyright © 2016 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectLogSignatureCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *driverView;
@property (weak, nonatomic) IBOutlet UILabel *driverSignatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverSignatureDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *driverSignImgView;

@property (weak, nonatomic) IBOutlet UIView *mechanicView;
@property (weak, nonatomic) IBOutlet UILabel *mechanicSignatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *mechanicSignatureDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mechanicSignImgView;

@end
