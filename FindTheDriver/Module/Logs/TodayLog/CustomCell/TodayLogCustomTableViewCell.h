//
//  TodayLogCustomTableViewCell.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayLogCustomTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIButton *statusBtn;
@property (nonatomic, weak) IBOutlet UILabel *timeLbl;
@property (nonatomic, weak) IBOutlet UIButton *locationBtn;

@end
