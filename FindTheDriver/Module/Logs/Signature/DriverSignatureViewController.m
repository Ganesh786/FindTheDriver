//
//  DriverSignatureViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "DriverSignatureViewController.h"

@interface DriverSignatureViewController ()

@property (weak, nonatomic) IBOutlet UIButton *previewLogBtn;
@property (weak, nonatomic) IBOutlet UIButton *addSignatureBtn;

@end

@implementation DriverSignatureViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDriverSignatureViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadDriverSignatureViewComponents {
    [SCUIUtility setLayerForView:_previewLogBtn WithColor:kClearColor];
    [SCUIUtility setLayerForView:_addSignatureBtn WithColor:kClearColor];
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
