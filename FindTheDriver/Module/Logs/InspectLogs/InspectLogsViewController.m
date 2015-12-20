//
//  InspectLogsViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "InspectLogsViewController.h"
#import "InspectLogsCustomTableViewCell.h"
#import "AddNewDVIRViewController.h"
#import "MFSideMenu.h"

@interface InspectLogsViewController ()
{
    NSMutableArray *defectsArray;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *inspectLogsNavigationItem;
@end

@implementation InspectLogsViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInspectLogsViewComponents];
    
    defectsArray = [NSMutableArray array];
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:@"Defects" forKey:@"Name"];
    [dict1 setValue:@"Air Compressor" forKey:@"Title"];
    [dict1 setValue:@"Insufficient Compression" forKey:@"Description"];
    [defectsArray addObject:dict1];
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setValue:@"Corrections" forKey:@"Name"];
    [dict2 setValue:@"Windows" forKey:@"Title"];
    [dict2 setValue:@"Oil Leak" forKey:@"Description"];
    [defectsArray addObject:dict2];
    _driverSignatureView.backgroundColor = [UIColor lightGrayColor];
    _mechanicSignatureView.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backBtnClciked:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)sideBarBtnClicked:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];

}

#pragma mark - User defined methods

- (void)loadInspectLogsViewComponents {
    
    if (UIAppDelegate.isSideBarInspectLogsClicked == YES) {
        UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sideBar.png"] style:UIBarButtonItemStylePlain target:self action:@selector(sideBarBtnClicked:)];
        sidebarButton.tintColor = kWhiteColor;
        _inspectLogsNavigationItem.leftBarButtonItem = sidebarButton;
    } else
        [self setBackBarButtonItem];

}

#pragma mark - TableView delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return defectsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellOneID = @"logsCell";
    InspectLogsCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellOneID forIndexPath:indexPath];
    if (cell == nil)
        cell = [[InspectLogsCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellOneID];
    NSDictionary *dict = [defectsArray objectAtIndex:indexPath.row];
    cell.lblName.text = [dict valueForKey:@"Name"];
    cell.lblTitle.text = [dict valueForKey:@"Title"];
    cell.lblDescription.text = [dict valueForKey:@"Description"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)btnAddRemoveDefectsPressed:(id)sender {
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:@"Defects Included" forKey:@"Name"];
    [dict1 setValue:@"Tube" forKey:@"Title"];
    [dict1 setValue:@"Leakage" forKey:@"Description"];
    [defectsArray addObject:dict1];
    [_tblDefects reloadData];
}

- (IBAction)btnAddNewDVIRPressed:(id)sender {
    AddNewDVIRViewController *newDVIRViewController = [kLogsStoryboard instantiateViewControllerWithIdentifier:@"addNewDVIRVC"];
    [self.navigationController pushViewController:newDVIRViewController animated:NO];
}

@end
