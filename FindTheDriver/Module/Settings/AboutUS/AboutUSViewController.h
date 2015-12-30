//
//  AboutUSViewController.h
//  FindTheDriver
//
//  Created by mac on 25/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightsLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
