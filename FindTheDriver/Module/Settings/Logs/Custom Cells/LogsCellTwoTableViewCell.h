//
//  LogsCellTwoTableViewCell.h
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 11/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogsCellTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblToggleOne;
@property (weak, nonatomic) IBOutlet UILabel *lblToggleTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnToggleOne;
@property (weak, nonatomic) IBOutlet UIButton *btnToggleTwo;
- (IBAction)btnToggleOneClicked:(id)sender;
- (IBAction)btnToggleTwoClicked:(id)sender;

@end
