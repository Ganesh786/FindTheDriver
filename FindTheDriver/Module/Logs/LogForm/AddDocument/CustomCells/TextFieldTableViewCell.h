//
//  TextFieldTableViewCell.h
//  FindTheDriver
//
//  Created by mac on 26/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
