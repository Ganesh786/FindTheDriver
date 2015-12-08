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
    
}

- (IBAction)addBtnClicked:(id)sender {
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
