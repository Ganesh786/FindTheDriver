//
//  AccountSettingsViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 06/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "AccountSettingsViewController.h"
#import "AccountInfoCustomTableViewCell.h"
#import "VehicleInfoTableViewCell.h"
#import "ChangePasswordViewController.h"
#import "RegisterNewVehicleViewController.h"

@interface AccountSettingsViewController () <UITextFieldDelegate> {
    UITextField *driverNameTxtFld, *driverIDTxtFld, *phoneNumberTxtFld, *emailIDTxtFld;
}

@property (weak, nonatomic) IBOutlet UITableView *driverBasicInfoTblView;
@property (weak, nonatomic) IBOutlet UITableView *vehicleInfoTblView;
@property (weak, nonatomic) IBOutlet UIButton *profilePicBtn;
@property (weak, nonatomic) IBOutlet UIButton *changePwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerVehicleBtn;

@end

@implementation AccountSettingsViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadAccountSettingsViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadAccountSettingsViewController {
    _driverBasicInfoTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setBackBarButtonItem];
    [self setNavigationBarNameWithNameAttribute:@"Account Settings"];
    [SCUIUtility setLayerForView:_changePwdBtn WithColor:kClearColor];
    [SCUIUtility setLayerForView:_registerVehicleBtn WithColor:kClearColor];
}

- (void)setEventsForTheTextFld:(UITextField *)txtFld {
    int tag = (int)txtFld.tag;
    switch (tag) {
        case 0:
            driverNameTxtFld = txtFld;
            driverNameTxtFld.placeholder = @"Driver Name";
            driverNameTxtFld.autocapitalizationType=UITextAutocapitalizationTypeWords;
            driverNameTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            driverNameTxtFld.returnKeyType = UIReturnKeyNext;
            break;
            
        case 1:
            driverIDTxtFld = txtFld;
            driverIDTxtFld.placeholder = @"Driver ID";
            driverIDTxtFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
            driverIDTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            driverIDTxtFld.returnKeyType = UIReturnKeyNext;
            break;
            
        case 2:
            phoneNumberTxtFld = txtFld;
            phoneNumberTxtFld.placeholder = @"Phone Number";
            phoneNumberTxtFld.keyboardType = UIKeyboardTypePhonePad;
            break;
            
        case 3:
            emailIDTxtFld = txtFld;
            emailIDTxtFld.placeholder = @"Email ID";
            emailIDTxtFld.keyboardType = UIKeyboardTypeEmailAddress;
            emailIDTxtFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
            emailIDTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            emailIDTxtFld.returnKeyType = UIReturnKeyDefault;
            break;

        default:
            break;
    }
}

#pragma mark - User Action methods

- (IBAction)profilePicBtnClicked:(id)sender {
    
}

- (IBAction)changePwdBtnClicked:(id)sender {
    ChangePasswordViewController *chnagePwdVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
    [UIAppDelegate.navigationController pushViewController:chnagePwdVC animated:YES];
}

- (IBAction)registerNewVehicleBtnClicked:(id)sender {
    RegisterNewVehicleViewController *registerVc = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"RegisterVehicleID"];
    [UIAppDelegate.navigationController pushViewController:registerVc animated:YES];
}

#pragma mark - TableView Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) return 4;
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *accountInfoCellID = @"AccountCellID";
    static NSString *vehicleInfoCellID = @"VehicleCellID";
    
    if (tableView.tag == 1) {
        AccountInfoCustomTableViewCell *accountInfoCell = (AccountInfoCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:accountInfoCellID];
        
        UITextField *regTextField = accountInfoCell.driverTextFld;
        regTextField.tag = indexPath.row;
        regTextField.delegate = self;
        [self setEventsForTheTextFld:regTextField];
        
        return accountInfoCell;
    }
    VehicleInfoTableViewCell *vehicleInfoCell = (VehicleInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:vehicleInfoCellID];
    
    return vehicleInfoCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
