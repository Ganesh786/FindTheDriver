//
//  SignatureViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 08/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "SignatureViewController.h"

@interface SignatureViewController ()<PPSSignatureViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *signatureBgView;
@property (weak, nonatomic) IBOutlet UIView *signatureView;
@property (weak, nonatomic) IBOutlet UIImageView *signatureImgView;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnOutlet;
@property (nonatomic, strong) PPSSignatureView *signatureViewInternal;

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
    
    UIImage *signature=[SCDataUtility galleryImage:DRIVER_SIGNATURE];
    if (signature != nil) {
        self.signatureImgView.image=signature;
    }
    self.signatureBgView.layer.borderColor = [UIColor colorFromHexString:@"#208BDC"].CGColor;
    self.signatureBgView.layer.borderWidth = 1;
    [SCUIUtility setLayerForView:_changeBtn WithColor:kClearColor];
    
}

- (void)setupSignatureField {
    self.signatureViewInternal = [[PPSSignatureView alloc] initWithFrame:self.signatureView.frame context:nil];
    self.signatureViewInternal.signatureDelegate = self;
    self.signatureViewInternal.backgroundColor = self.signatureView.backgroundColor;
    [self.signatureView addSubview:self.signatureViewInternal];
}

- (void)signatureAvailable:(BOOL)signatureAvailable {
    if (signatureAvailable) {
        //Enable buttons
    } else {
        //disable buttons
    }
}

-(void)clearSignature {
    [self.signatureViewInternal erase];
}

-(UIImage *)signature {
    return [self.signatureViewInternal signatureImage];
}


#pragma mark - User Action methods

- (IBAction)cancelBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES]; 
}

- (IBAction)saveBtnClicked:(id)sender {
    if ([self signature]) {
    self.signatureImgView.hidden=NO;
    self.signatureImgView.image=[self signature];
    [SCDataUtility writeGalleryImage:[self signature] imagename:DRIVER_SIGNATURE];
    [self clearSignature];
    self.signatureViewInternal=nil;
    }else{
        [self showAlert:@"" message:@"Please do signature to save."];
    }
}

- (IBAction)changeBtnClicked:(id)sender {
    self.signatureImgView.hidden=YES;
    [self clearSignature];
    [self setupSignatureField];
}

@end
