//
//  LogsCellOneTableViewCell.h
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 11/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogsCellOneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnTimeZone;
- (IBAction)btnTimeZoneClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCycle;
- (IBAction)btnCycleClicked:(id)sender;
@property (nonatomic, strong) id delegate;
@end

@protocol CellOneDelegate <NSObject>

-(void)showPicker:(BOOL)isTimeZone;

@end