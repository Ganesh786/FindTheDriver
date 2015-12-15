//
//  RegistrationViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 30/11/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "RegistrationViewController.h"
#import "RegistrationTableViewCell.h"
#import "RegistrationFualTableViewCell.h"

#define ACCEPTABLE_CHARECTERS @"0123456789"

@interface RegistrationViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSArray *headerLblsArray;
    UITextField *driverNameTxtFld, *driverEmailTxtFld, *driverPhoneTxtFld, *carNickNameTxtFld, *colorTxtFld, *regPlateTextFld;
    BOOL isDieselSelected;
}

@property (weak, nonatomic) IBOutlet UITableView *registrationTblView;

@end

@implementation RegistrationViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden  = NO;
    [self setNavigationBarNameWithNameAttribute:@"Create a New Account"];

    [self loadRegistrationViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadRegistrationViewComponents {
    headerLblsArray = @[@"Driver Name",@"Driver Email",@"Driver Phone (optional)",@"Car Nick Name",@"Color", @"Registration Plate"];
    
    _registrationTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _registrationTblView.bounces = NO;
    isDieselSelected = YES;
}

- (void)setEventsForTheTextFld:(UITextField *)txtFld {
    int tag = (int)txtFld.tag;
    switch (tag) {
        case 0:
            // Setting the properties for driverNameTxtFld text feild
            driverNameTxtFld = txtFld;
            driverNameTxtFld.autocapitalizationType=UITextAutocapitalizationTypeWords;
            driverNameTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            driverNameTxtFld.returnKeyType = UIReturnKeyNext;
            break;
            
        case 1:
            // Setting the properties for email text feild
            driverEmailTxtFld = txtFld;
            driverEmailTxtFld.keyboardType = UIKeyboardTypeEmailAddress;
            driverEmailTxtFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
            driverEmailTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            driverEmailTxtFld.returnKeyType = UIReturnKeyNext;
            break;
            
        case 2:
            // Setting the properties for phone text feild
            driverPhoneTxtFld = txtFld;
            driverPhoneTxtFld.keyboardType = UIKeyboardTypePhonePad;
            driverPhoneTxtFld.returnKeyType = UIReturnKeyNext;
            break;
            
        case 3:
            // Setting the properties for nick name text feild
            carNickNameTxtFld = txtFld;
            carNickNameTxtFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
            carNickNameTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            carNickNameTxtFld.returnKeyType = UIReturnKeyNext;
            break;
            
        case 4:
            // Setting the properties for registration plate text feild
            colorTxtFld = txtFld;
            colorTxtFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
            colorTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
            colorTxtFld.returnKeyType = UIReturnKeyNext;
            break;

        case 5:
            // Setting the properties for registration plate text feild
            regPlateTextFld = txtFld;
            regPlateTextFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
            regPlateTextFld.autocorrectionType = UITextAutocorrectionTypeNo;
            regPlateTextFld.returnKeyType = UIReturnKeyDefault;
            break;

        default:
            break;
    }
}

- (IBAction)sliderTransparentBtnClicked:(id)sender {
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:6 inSection:0];

    RegistrationFualTableViewCell *fualCell = [_registrationTblView cellForRowAtIndexPath:indexpath];
    if (isDieselSelected == YES) {
        isDieselSelected = NO;
        [fualCell.fualSlider setValue:0];
    } else {
        isDieselSelected = YES;
        [fualCell.fualSlider setValue:1];
    }
    [_registrationTblView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)registerBtnClicked:(id)sender {
    if ([SCUIUtility validateString:driverNameTxtFld.text].length>0 && [SCUIUtility validateString:driverEmailTxtFld.text].length>0 && [SCUIUtility validateString:carNickNameTxtFld.text].length>0 && [SCUIUtility validateString:colorTxtFld.text].length>0 && [SCUIUtility validateString:regPlateTextFld.text].length>0) {
        if ([SCUIUtility validateEmailWithString:driverEmailTxtFld.text]) {
            NSMutableDictionary *regDict=[NSMutableDictionary new];
            [regDict setObject:driverNameTxtFld.text forKey:@"DriverName"];
            [regDict setObject:driverPhoneTxtFld.text forKey:@"Phoneno"];
            [regDict setObject:@"" forKey:@"Address"];
            [regDict setObject:driverEmailTxtFld.text forKey:@"Email"];
            [regDict setObject:carNickNameTxtFld.text forKey:@"CarName"];
            [regDict setObject:colorTxtFld.text forKey:@"Color"];
            [regDict setObject:regPlateTextFld.text forKey:@"RegistrationPlate"];
            [regDict setObject:isDieselSelected?@"Diesel":@"Gas" forKey:@"FuelType"];
            
            [[RegistrationModel alloc]registrationAPICall:regDict completionBlock:^(BOOL success, NSString *message, NSDictionary *dataDict) {
                DEBUGLOG(@"message ->%@ dataDict ->%@",message,dataDict);
                if (success) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self showAlert:@"" message:message];
                }
            }];
        }else{
            [self showAlert:@"" message:@"Enter Valid Email ID"];
        }
    }else{
        [self showAlert:@"" message:@"All fields are mandatory."];
    }
}

#pragma mark - Tableview Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return headerLblsArray.count +1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6)
        return 100;
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *registerUserInputCellID = @"RegistrationCellID";
    static NSString *registerFualInputCellID = @"RegistrationFualCellID";

    if (indexPath.row == 6) {
        RegistrationFualTableViewCell *registerFualInputCell = (RegistrationFualTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerFualInputCellID];
        registerFualInputCell.backgroundColor = kClearColor;

        return registerFualInputCell;
    }
    
    RegistrationTableViewCell *registerUserInputCell = (RegistrationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerUserInputCellID];
    registerUserInputCell.backgroundColor = kClearColor;
    registerUserInputCell.headerLbl.text = headerLblsArray[indexPath.row];
    
    UITextField *regTextField = registerUserInputCell.detailTxtFld;
    regTextField.tag = indexPath.row;
    regTextField.delegate = self;
    [self setEventsForTheTextFld:regTextField];
    
    return registerUserInputCell;
}


#pragma mark - TextField Delegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Password, Confirm password, firstname, lastname max length is 20
//    if (textField == passwordTxtFld || textField == confirmPasswordTxtFld) {
//        NSUInteger newLength = (textField.text).length + string.length - range.length;
//        return (newLength > kMAXCHAR_FOR_PASSWORD) ? NO : YES;
//    }
//    
//    // Email textfield max length is 50
//    if (textField == emailTxtFld) {
//        NSUInteger newLength = (textField.text).length + string.length - range.length;
//        return (newLength > 50) ? NO : YES;
//    }
//    
//    //Checks the maximum character and accepts only alphabets,space characters
//    if(textField == firstNameTxtFld || textField==lastNameTxtFld) {
//        // To Prevent crashing on undo after pasted some text in textfield and if paste is not allowed for validation then
//        //this resolve the crash.
//        if(range.length + range.location > textField.text.length)
//            return NO;
//        
//        NSUInteger newLength = (textField.text).length + string.length - range.length;
//        
//        if (newLength<=kMAXCHAR_FOR_NAME) {
//            NSCharacterSet *validCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "].invertedSet;
//            return ([string rangeOfCharacterFromSet:validCharSet].location==NSNotFound);
//        }
//        return NO;
//    }
    
    if (textField == driverPhoneTxtFld) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (updatedText.length > 25)
        {return NO;}
        return [string isEqualToString:filtered];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITextField *becomeTextField, *resignTxtFld;
    
    if (textField == driverNameTxtFld) {
        resignTxtFld = driverNameTxtFld;
        becomeTextField=driverEmailTxtFld;
        
    } else if (textField == driverEmailTxtFld) {
        resignTxtFld = driverEmailTxtFld;
        becomeTextField=driverPhoneTxtFld;
        
    } else if (textField == driverPhoneTxtFld) {
        resignTxtFld = driverPhoneTxtFld;
        becomeTextField=carNickNameTxtFld;
        
    } else if (textField == carNickNameTxtFld) {
        resignTxtFld = carNickNameTxtFld;
        becomeTextField=colorTxtFld;
        
    } else if (textField == colorTxtFld) {
        resignTxtFld = colorTxtFld;
        becomeTextField=regPlateTextFld;
        
    }  else if (textField == regPlateTextFld) {
        resignTxtFld = regPlateTextFld;
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
