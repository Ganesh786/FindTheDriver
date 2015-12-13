//
//  InspectLogsViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectLogsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblVIRNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblDateOfSubmission;
@property (weak, nonatomic) IBOutlet UITableView *tblDefects;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverSignatureDate;
@property (weak, nonatomic) IBOutlet UILabel *lblMechanicSignatureDate;
@property (weak, nonatomic) IBOutlet UIImageView *driverSignatureView;
@property (weak, nonatomic) IBOutlet UIImageView *mechanicSignatureView;
@property (weak, nonatomic) IBOutlet UIButton *btnAddRemoveDefects;
- (IBAction)btnAddRemoveDefectsPressed:(id)sender;
- (IBAction)btnAddNewDVIRPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAddNewDVIR;

@end
