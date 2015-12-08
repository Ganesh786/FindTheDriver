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
    
}

- (IBAction)saveBtnClicked:(id)sender {
    
}

- (IBAction)changeBtnClicked:(id)sender {
    
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
