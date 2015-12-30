//
//  DropDownTableViewCell.m
//  FindTheDriver
//
//  Created by mac on 26/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "DropDownTableViewCell.h"

@implementation DropDownTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.bgView.layer.cornerRadius=5.0f;
    self.bgView.layer.borderWidth=1.0f;
    self.bgView.layer.borderColor=kGrayColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
