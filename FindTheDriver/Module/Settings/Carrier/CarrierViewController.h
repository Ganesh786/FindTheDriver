//
//  CarrierViewController.h
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 09/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarrierViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblCarrierName;
@property (weak, nonatomic) IBOutlet UILabel *lblOfficeAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblHomeAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIView *viewAddressEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UITextField *txtAddressEdit1;
@property (weak, nonatomic) IBOutlet UITextField *txtAddressEdit2;
@property (weak, nonatomic) IBOutlet UITextField *txtAddressEdit3;
- (IBAction)btnEditPressed:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;
@end
