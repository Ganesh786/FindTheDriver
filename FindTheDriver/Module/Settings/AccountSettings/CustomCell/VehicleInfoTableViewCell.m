//
//  VehicleInfoTableViewCell.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 06/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "VehicleInfoTableViewCell.h"

@implementation VehicleInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [SCUIUtility setLayerForView:_bgView WithColor:kLightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
