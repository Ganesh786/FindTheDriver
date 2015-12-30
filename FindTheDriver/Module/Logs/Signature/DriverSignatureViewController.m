//
//  DriverSignatureViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "DriverSignatureViewController.h"
#import "DriverActionCustomTableViewCell.h"

#pragma PenColor    ([UIColor blackColor])

@interface DriverSignatureViewController () <PPSSignatureViewDelegate>{
    NSArray *nameArray, *imagesArray;
}

@property (nonatomic, strong) PPSSignatureView *signatureViewInternal;

@property (weak, nonatomic) IBOutlet UIButton *previewLogBtn;
@property (weak, nonatomic) IBOutlet UIButton *addSignatureBtn;
@property (weak, nonatomic) IBOutlet UITableView *actionTblView;
@property (weak, nonatomic) IBOutlet UINavigationItem *signatureNavigationItem;
@property (weak, nonatomic) IBOutlet UIView *signatureBGView;
@property (weak, nonatomic) IBOutlet UIImageView *signatureImgView;
@property (weak, nonatomic) IBOutlet UIButton *signatureCloseBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnOutlet;

@end

@implementation DriverSignatureViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDriverSignatureViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - User defined methods

- (void)loadDriverSignatureViewComponents {
    [SCUIUtility setLayerForView:_previewLogBtn WithColor:kClearColor];
    [SCUIUtility setLayerForView:_addSignatureBtn WithColor:kClearColor];
    
    [self.signatureCloseBtnOutlet setHidden:YES];
    [self.cancelBtnOutlet setHidden:YES];
    [self.saveBtnOutlet setHidden:YES];

    nameArray = [NSArray arrayWithObjects:@"Send", @"Print", nil];
    imagesArray = [NSArray arrayWithObjects:@"Email.png", @"Printer.png", nil];
    _actionTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _signatureNavigationItem.title = @"Monday | October 10";
}

#pragma mark - User Action Methods

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)previewLogBtnClicked:(id)sender {
    [UIAlertView showAlertViewWithTitle:@"" Message:kComingSoon];
}

- (IBAction)touchAndSignatureBtnClicked:(id)sender {
    _addSignatureBtn.hidden = YES;
    
    UIImage *signature=[SCDataUtility galleryImage:DRIVER_SIGNATURE];
    if (signature != nil) {
        self.signatureImgView.image=signature;
        [self.signatureCloseBtnOutlet setHidden:NO];
    }else{
        [self closeBtnClicked:nil];
    }
}

- (IBAction)closeBtnClicked:(id)sender {
    [self.signatureCloseBtnOutlet setHidden:YES];
    _signatureImgView.image = nil;
    _signatureImgView.hidden=YES;
    [self clearSignature];
    [self setupSignatureField];
    
    [self.cancelBtnOutlet setHidden:NO];
    [self.saveBtnOutlet setHidden:NO];
    self.tabBarController.tabBar.hidden=YES;
}


- (void)setupSignatureField {
    self.signatureViewInternal = [[PPSSignatureView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 95) context:nil];
    self.signatureViewInternal.signatureDelegate = self;
    self.signatureViewInternal.backgroundColor = self.signatureBGView.backgroundColor;
    [self.signatureBGView addSubview:self.signatureViewInternal];
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

- (IBAction)saveBtnAction:(id)sender {
    if ([self signature]) {
        self.signatureImgView.hidden=NO;
        self.signatureImgView.image=[self signature];
        [SCDataUtility writeGalleryImage:[self signature] imagename:DRIVER_SIGNATURE];
        [self.signatureCloseBtnOutlet setHidden:NO];
        [self cancelBtnAction:nil];
    }else{
        [UIAlertView showAlertViewWithTitle:@"" Message:@"Please do signature to save."];
    }
}

- (IBAction)cancelBtnAction:(id)sender {
    UIImage *signature=[SCDataUtility galleryImage:DRIVER_SIGNATURE];
    if (signature == nil) {
    _addSignatureBtn.hidden = NO;
    }else{
        self.signatureImgView.hidden=NO;
        self.signatureImgView.image=signature;
        [self.signatureCloseBtnOutlet setHidden:NO];
    }
    [self clearSignature];
    [self.signatureViewInternal removeFromSuperview];
    self.signatureViewInternal=nil;
    [self.cancelBtnOutlet setHidden:YES];
    [self.saveBtnOutlet setHidden:YES];
    self.tabBarController.tabBar.hidden=NO;
}


#pragma mark - Tableview delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return nameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *driverActionCellID = @"DriverActionID";
    
    DriverActionCustomTableViewCell *driverActionCell = (DriverActionCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:driverActionCellID];
    driverActionCell.nameLbl.text = nameArray[indexPath.row];
    driverActionCell.actionImgView.image = [UIImage imageNamed:imagesArray[indexPath.row]];

    return driverActionCell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
