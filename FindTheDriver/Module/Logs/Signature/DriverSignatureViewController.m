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
@property (weak, nonatomic) IBOutlet UITableView *actionTblView;

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
}

@end
