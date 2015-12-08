//
//  RegistrationFualTableViewCell.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 01/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "RegistrationFualTableViewCell.h"

@implementation RegistrationFualTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _fualSlider.clipsToBounds = YES;
    _fualSlider.layer.cornerRadius = 17;

    [_fualSlider setThumbImage:[_fualSlider thumbImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    _fualSlider.thumbTintColor = [UIColor colorFromHexString:@"#32DAA3"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
