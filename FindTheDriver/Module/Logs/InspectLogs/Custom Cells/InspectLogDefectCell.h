//
//  InspectLogDefectCell.h
//  FindTheDriver
//
//  Created by mac on 02/01/16.
//  Copyright © 2016 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectLogDefectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *defectsLabel;
@property (weak, nonatomic) IBOutlet UILabel *defectIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *defectIDSubLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *defectBtnOutlet;

@end
