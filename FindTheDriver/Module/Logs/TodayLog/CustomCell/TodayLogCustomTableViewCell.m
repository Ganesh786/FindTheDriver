//
//  TodayLogCustomTableViewCell.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "TodayLogCustomTableViewCell.h"

@implementation TodayLogCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _statusBtn.layer.cornerRadius = 9;
    _statusBtn.layer.borderWidth = 1;
    _statusBtn.layer.borderColor = kClearColor.CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
