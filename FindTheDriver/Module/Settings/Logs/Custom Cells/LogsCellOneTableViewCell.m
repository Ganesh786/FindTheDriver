//
//  LogsCellOneTableViewCell.m
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 11/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "LogsCellOneTableViewCell.h"

@implementation LogsCellOneTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnTimeZoneClicked:(id)sender {
    [self.delegate showPicker:YES];
}
- (IBAction)btnCycleClicked:(id)sender {
    [self.delegate showPicker:NO];
}
@end
