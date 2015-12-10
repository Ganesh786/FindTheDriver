//
//  LogsViewController.h
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 11/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogsCellOneTableViewCell.h"
#import "LogsCellTwoTableViewCell.h"

@interface LogsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,CellOneDelegate>
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerTimeZone;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCycle;

@end
