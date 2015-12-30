//
//  InspectLogsCustomTableViewCell.h
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectLogsCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBadge;
@property (weak, nonatomic) IBOutlet UIButton *btnTick;
@end
