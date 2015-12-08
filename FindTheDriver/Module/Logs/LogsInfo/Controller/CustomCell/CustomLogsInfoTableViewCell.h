//
//  CustomLogsInfoTableViewCell.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 06/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLogsInfoTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *dayNameLbl;
@property (nonatomic, weak) IBOutlet UILabel *hourNameLbl;
@property (nonatomic, weak) IBOutlet UILabel *noDVRLbl;
@property (nonatomic, weak) IBOutlet UIImageView *hoursImgView;
@property (nonatomic, weak) IBOutlet UIImageView *noDVIRImgView;

@end
