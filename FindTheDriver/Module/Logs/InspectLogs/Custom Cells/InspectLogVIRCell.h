//
//  InspectLogVIRCell.h
//  FindTheDriver
//
//  Created by mac on 02/01/16.
//  Copyright © 2016 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectLogVIRCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *virLabel;
@property (weak, nonatomic) IBOutlet UILabel *virIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *daySubLabel;
@property (weak, nonatomic) IBOutlet UILabel *daySubIDLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
