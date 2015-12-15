//
//  DriverSignatureViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "DriverSignatureViewController.h"
#import "DriverActionCustomTableViewCell.h"

@interface DriverSignatureViewController () {
    NSArray *nameArray, *imagesArray;
}

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
    
    nameArray = [NSArray arrayWithObjects:@"Send", @"Print", nil];
    imagesArray = [NSArray arrayWithObjects:@"Email.png", @"Printer.png", nil];
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

@end
