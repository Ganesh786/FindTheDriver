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

@interface AccountSettingsViewController () <UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource> {
    UITextField *driverNameTxtFld, *driverIDTxtFld, *phoneNumberTxtFld, *emailIDTxtFld;
    UIImage *profileImage;
    NSMutableArray *vehiclesDataArray;
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
    _profilePicBtn.layer.cornerRadius=35;
    _profilePicBtn.layer.masksToBounds=YES;
    vehiclesDataArray=[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getVehiclesData]; //Get Vehicles Data
}

#pragma mark:- Get Vehicles Data
-(void)getVehiclesData{
    [[CustomLoaderView sharedView] showLoader];
    [[GetVehicleModel alloc]getVehiclesAPICall:[NSString stringWithFormat:@"%@/%@",[SCDataUtility getUserName],[SCDataUtility getUserPassword]] completionBlock:^(BOOL success, NSString *message, id dataDict) {
        [[CustomLoaderView sharedView] dismissLoader];
        DEBUGLOG(@"GetVehicleModel message ->%@ dataDict ->%@",message,dataDict);
        if ([dataDict isKindOfClass:[NSArray class]]) {
            vehiclesDataArray=dataDict;
            [_vehicleInfoTblView reloadData];
        }
        if (!success) {
            [self showAlert:@"" message:message];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadAccountSettingsViewController {
    _driverBasicInfoTblView.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
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
            driverNameTxtFld.delegate=self;
            break;
            
        case 1:
            driverIDTxtFld = txtFld;
            driverIDTxtFld.placeholder = @"Driver ID";
            driverIDTxtFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
            driverIDTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            driverIDTxtFld.returnKeyType = UIReturnKeyNext;
            driverIDTxtFld.delegate=self;
            break;
            
        case 2:
            phoneNumberTxtFld = txtFld;
            phoneNumberTxtFld.placeholder = @"Phone Number";
            phoneNumberTxtFld.keyboardType = UIKeyboardTypePhonePad;
            phoneNumberTxtFld.returnKeyType = UIReturnKeyNext;
            phoneNumberTxtFld.delegate=self;
            break;
            
        case 3:
            emailIDTxtFld = txtFld;
            emailIDTxtFld.placeholder = @"Email ID";
            emailIDTxtFld.keyboardType = UIKeyboardTypeEmailAddress;
            emailIDTxtFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
            emailIDTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            emailIDTxtFld.returnKeyType = UIReturnKeyDefault;
            emailIDTxtFld.delegate=self;
            break;

        default:
            break;
    }
}

#pragma mark - User Action methods
- (IBAction)updateProfileBtnClicked:(id)sender {
    NSString *driverName=[SCUIUtility validateString:driverNameTxtFld.text];
    NSString *driverID=[SCUIUtility validateString:driverIDTxtFld.text];
    NSString *driverEmailID=[SCUIUtility validateString:emailIDTxtFld.text];
    NSString *driverPhNum=[SCUIUtility validateString:phoneNumberTxtFld.text];
    if (driverName.length>0 || driverID.length>0 || driverEmailID.length>0 || driverPhNum.length>0) {
        if (driverName.length>0) {
            if (driverID.length>0) {
                if (driverPhNum.length>0) {
                    if ([SCUIUtility validateEmailWithString:driverEmailID]) {
                        [self.view endEditing:YES];
                        [[CustomLoaderView sharedView] showLoader];
                        [[UpDateProfileModel alloc] upDateProfileAPICall:[NSString stringWithFormat:@"%@/%@/%@/%@",[SCDataUtility getUserName],[SCDataUtility getUserPassword],driverName,driverPhNum] params:nil completionBlock:^(BOOL success, NSString *message, id dataDict) {
                            DEBUGLOG(@"UpDateProfileModel message ->%@ dataDict ->%@",message,dataDict);
                            [[CustomLoaderView sharedView] dismissLoader];
                            if (success) {
                                [self showAlert:@"" message:@"Profile Update Successfully"];
                            }else{
                                [self showAlert:@"" message:message];
                            }
                        }];
                    }else{
                        [self showAlert:@"" message:@"Please Enter a Valid Email ID"];
                    }
                }else{
                    [self showAlert:@"" message:@"Please Enter Phone Number"];
                }
            }else{
                [self showAlert:@"" message:@"Please Enter Driver ID"];
            }
        }else{
            [self showAlert:@"" message:@"Please Enter Driver Name"];
        }
    }else{
        [self showAlert:@"" message:@"All fields are mandatory."];
    }
}

- (IBAction)profilePicBtnClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil otherButtonTitles:@"Capture",@"Attach", nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Capture"]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.navigationBar.barStyle = UIBarStyleBlackOpaque;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
    if ([buttonTitle isEqualToString:@"Attach"]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.navigationBar.barStyle = UIBarStyleBlackOpaque;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}


#pragma mark UIImagePicker Delegate Methods

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    profileImage=[info valueForKey:UIImagePickerControllerOriginalImage];
    [_profilePicBtn setImage:profileImage forState:UIControlStateNormal];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        [self showAlert:@"Ooopss !" message:@"Failed to upload !!"];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changePwdBtnClicked:(id)sender {
    ChangePasswordViewController *chnagePwdVC = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
    [UIAppDelegate.navigationController pushViewController:chnagePwdVC animated:YES];
}

- (IBAction)registerNewVehicleBtnClicked:(id)sender {
    RegisterNewVehicleViewController *registerVc = [kSettingsStoryboard instantiateViewControllerWithIdentifier:@"RegisterVehicleID"];
    [UIAppDelegate.navigationController pushViewController:registerVc animated:YES];
}

#pragma mark:- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) return 4;
    return vehiclesDataArray.count;
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
    vehicleInfoCell.vehicleNameLbl.text=[SCUIUtility validateString:[[vehiclesDataArray objectAtIndex:indexPath.row] valueForKey:@"RegistrationNumber"]];
    return vehicleInfoCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag != 1) {
        [self deleteVehicleFromTheList:[vehiclesDataArray objectAtIndex:indexPath.row] index:indexPath.row];
    }
}

-(void)deleteVehicleFromTheList:(NSDictionary*)vehicleDict index:(NSInteger)index{
    DeleteVehicleDataModel *dataModel=[[DeleteVehicleDataModel alloc]init];
    dataModel.CarName=[SCUIUtility validateString:[vehicleDict valueForKey:@"CarName"]];
    dataModel.Color=[SCUIUtility validateString:[vehicleDict valueForKey:@"Color"]];
    dataModel.RegistrationPlate=[SCUIUtility validateString:[vehicleDict valueForKey:@"RegistrationNumber"]];
    dataModel.FuelType=[SCUIUtility validateString:[vehicleDict valueForKey:@"Type"]];
    NSDictionary *dict=[SCDataUtility getDictionaryBasaedOnObject:dataModel];
    [[CustomLoaderView sharedView] showLoader];
    [[DeleteVehicleModel alloc]deleteVehicleAPICall:[NSString stringWithFormat:@"%@/%@",[SCDataUtility getUserName],[SCDataUtility getUserPassword]] params:dict completionBlock:^(BOOL success, NSString *message, id dataDict) {
        DEBUGLOG(@"message ->%@ dataDict ->%@",message,dataDict);
        [[CustomLoaderView sharedView] dismissLoader];
        if (success) {
            [vehiclesDataArray removeObjectAtIndex:index];
            [_vehicleInfoTblView reloadData];
        }else{
            [self showAlert:@"" message:message];
            [_vehicleInfoTblView reloadData];
        }
    }];
}

#pragma mark:- Textfield Delegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == phoneNumberTxtFld) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (updatedText.length > PHONE_NUMBER_LIMIT)
        {return NO;}
        return [string isEqualToString:filtered];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITextField *becomeTextField, *resignTxtFld;
    if (textField == driverNameTxtFld) {
        resignTxtFld = driverNameTxtFld;
        becomeTextField=driverIDTxtFld;
    }else if (textField == driverIDTxtFld) {
        resignTxtFld = driverIDTxtFld;
        becomeTextField=emailIDTxtFld;
    }else if (textField == emailIDTxtFld) {
        resignTxtFld = emailIDTxtFld;
        becomeTextField=phoneNumberTxtFld;
    }else if (textField == phoneNumberTxtFld){
        resignTxtFld = phoneNumberTxtFld;
        becomeTextField=nil;
    }
    [resignTxtFld resignFirstResponder];
    [becomeTextField becomeFirstResponder];
    return YES;
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
