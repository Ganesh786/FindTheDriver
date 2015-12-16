//
//  RegisterNewVehicleViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 07/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "RegisterNewVehicleViewController.h"

@interface RegisterNewVehicleViewController () {
    BOOL isDieselSelected;
}

@property (weak, nonatomic) IBOutlet UISlider *fualSlider;
@property (weak, nonatomic) IBOutlet UIView *registerFualView;

@end

@implementation RegisterNewVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNewVehicleViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadNewVehicleViewComponents {
    [self setNavigationBarNameWithNameAttribute:@"Register New Vehicle"];
    [self setBackBarButtonItem];
    
    _fualSlider.layer.cornerRadius = 15;
    _fualSlider.layer.borderWidth = 1;
    _fualSlider.layer.borderColor = kClearColor.CGColor;

    isDieselSelected = YES;
}

#pragma mark - User action methods

- (IBAction)cancelBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addBtnClicked:(id)sender {
    NSString *vehicleNickName=[SCUIUtility validateString:_VehicleNickNameTextField.text];
    NSString *vehicleColor=[SCUIUtility validateString:_ColorTextField.text];
    NSString *vehicleRegPlate=[SCUIUtility validateString:_RegistrationPlateTextField.text];
    if (vehicleNickName.length>0 || vehicleColor.length>0 || vehicleRegPlate.length>0) {
        if (vehicleNickName.length>0) {
            if (vehicleColor.length>0) {
                if (vehicleRegPlate.length>0) {
                    RegisterNewVehicleDataModel *dataModel=[[RegisterNewVehicleDataModel alloc]init];
                    dataModel.CarName=vehicleNickName;
                    dataModel.Color=vehicleColor;
                    dataModel.RegistrationPlate=vehicleRegPlate;
                    dataModel.FuelType=isDieselSelected?@"Diesel":@"Gasoline";
                    
                    NSDictionary *dict=[SCDataUtility getDictionaryBasaedOnObject:dataModel];
                    [[RegisterNewVehicleModel alloc] newVehicleAPICall:[NSString stringWithFormat:@"%@/%@",[SCDataUtility getUserName],[SCDataUtility getUserPassword]] params:dict completionBlock:^(BOOL success, NSString *message, NSDictionary *dataDict) {
                        DEBUGLOG(@"message ->%@ dataDict ->%@",message,dataDict);
                        if (success) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }else{
                            [self showAlert:@"" message:message];
                        }
                    }];
                }else{
                    [self showAlert:@"" message:@"Please Enter Register Plate"];
                }
            }else{
                [self showAlert:@"" message:@"Please Enter Color"];
            }
        }else{
            [self showAlert:@"" message:@"Please Enter Vehicle NickName"];
        }
    }else{
        [self showAlert:@"" message:@"All fields are mandatory."];
    }
}

- (IBAction)fualSliderTransparentBtnClicked:(id)sender {
    if (isDieselSelected == YES) {
        isDieselSelected = NO;
        [_fualSlider setValue:0];
    } else {
        isDieselSelected = YES;
        [_fualSlider setValue:1];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITextField *becomeTextField, *resignTxtFld;
    if (textField == _VehicleNickNameTextField) {
        resignTxtFld = _VehicleNickNameTextField;
        becomeTextField=_ColorTextField;
    }else if (textField == _ColorTextField) {
        resignTxtFld = _ColorTextField;
        becomeTextField=_RegistrationPlateTextField;
    }else if (textField == _RegistrationPlateTextField) {
        resignTxtFld = _RegistrationPlateTextField;
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
