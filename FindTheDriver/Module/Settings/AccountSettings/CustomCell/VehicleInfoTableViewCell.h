//
//  VehicleInfoTableViewCell.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 06/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleInfoTableViewCell : UITableViewCell

@property (nonatomic, assign) IBOutlet UILabel *vehicleNameLbl;
@property (nonatomic, assign) IBOutlet UIButton *closeBtn;
@property (nonatomic, assign) IBOutlet UIView *bgView;

@end
