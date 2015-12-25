//
//  SignatureViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 08/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "SignatureViewController.h"

@interface SignatureViewController ()
@property (weak, nonatomic) IBOutlet UIView *signatureView;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnOutlet;

@end

@implementation SignatureViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSignatureViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadSignatureViewComponents {
    [self setNavigationBarNameWithNameAttribute:@"Signature"];
    [self setBackBarButtonItem];
    
    _signatureView.layer.borderColor = [UIColor colorFromHexString:@"#208BDC"].CGColor;
    _signatureView.layer.borderWidth = 1;
    [SCUIUtility setLayerForView:_changeBtn WithColor:kClearColor];
}

#pragma mark - User Action methods

- (IBAction)cancelBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES]; 
}

- (IBAction)saveBtnClicked:(id)sender {
    
}

- (IBAction)changeBtnClicked:(id)sender {
}

@end
