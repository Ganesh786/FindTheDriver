//
//  GridTimerViewCell.m
//  FindTheDriver
//
//  Created by mac on 19/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "GridTimerViewCell.h"
#import "GraphConstants.h"

@implementation GridTimerViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)editingStyle reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:editingStyle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Order Id
        self.timerLabel=[[UILabel alloc]initWithFrame:CGRectMake(2, (GRID_BOX_HT-20)/2, GRID_RIGHTVIEW_WT-2, 20)];
        self.timerLabel.textAlignment=NSTextAlignmentLeft;
        self.timerLabel.textColor=kBlackColor;
        self.timerLabel.font=[UIFont fontWithName:kHelveticaNeueFontName size:14];
        self.timerLabel.numberOfLines=1;
        self.timerLabel.adjustsFontSizeToFitWidth=YES;
        self.timerLabel.contentScaleFactor=0.8;
        [self.contentView addSubview:self.timerLabel];
    }
    return self;
}
@end
