//
//  RegisterNewVehicleViewController.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 07/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterNewVehicleModel.h"
#import "RegisterNewVehicleDataModel.h"
@interface RegisterNewVehicleViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *VehicleNickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ColorTextField;
@property (weak, nonatomic) IBOutlet UITextField *RegistrationPlateTextField;

@end
