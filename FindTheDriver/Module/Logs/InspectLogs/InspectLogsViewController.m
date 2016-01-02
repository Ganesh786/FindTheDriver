//
//  InspectLogsViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "InspectLogsViewController.h"
#import "InspectLogVIRCell.h"
#import "InspectLogDefectCell.h"
#import "InspectLogSignatureCell.h"
#import "InspectLogAddCell.h"

#import "AddNewDVIRViewController.h"
#import "MFSideMenu.h"

@interface InspectLogsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *tableDataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation InspectLogsViewController

#define kTitle        @"Title"
#define kValue        @"Value"
#define kSubValue     @"SubValue"
#define kSubTitle     @"SubTitle"
#define kDefectStatus @"DefectStatus"
#define kDefectCount  @"DefectCount"
#define kDriverSign    @"DriverSign"
#define kMechSign      @"MechSign"

#define kDefectSuccess @"Success"
#define kDefectError @"Error"

static NSString *kVIR   = @"VIR";
static NSString *kDefect   = @"Defect";
static NSString *kSignature   = @"Signature";
static NSString *kAddRemove   = @"AddRemove";

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    tableDataArray=[[NSMutableArray alloc]init];
    self.tableView.backgroundColor=kWhiteColor;
    self.tableView.tableFooterView=[self tableFooterView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setUpView];
}

-(void)setUpView{
  
    [tableDataArray removeAllObjects];
    
    for (int i=0; i<4; i++) {
        
    NSMutableArray *array=[[NSMutableArray alloc]init];
    [array addObject:[NSMutableDictionary dictionaryWithObjects:@[kVIR,@"2945",@"Oct. 25, 2015"] forKeys:@[kTitle,kValue,kSubValue]]];
    
    [array addObject:[NSMutableDictionary dictionaryWithObjects:@[kDefect,@"Defects",@"Air Compressor",@"Insufficient Compression",kDefectError,@"2"] forKeys:@[kTitle,kValue,kSubValue,kSubTitle,kDefectStatus,kDefectCount]]];
    [array addObject:[NSMutableDictionary dictionaryWithObjects:@[kDefect,@"Corrections",@"Windows",@"Oil Leak",kDefectSuccess,@"2"] forKeys:@[kTitle,kValue,kSubValue,kSubTitle,kDefectStatus,kDefectCount]]];

    [array addObject:[NSMutableDictionary dictionaryWithObjects:@[kSignature,@"Oct. 25, 2015",@"Oct, 25. 2015",@"Driver Sign URL",@"Mech Sign URL"] forKeys:@[kTitle,kValue,kSubValue,kDriverSign,kMechSign]]];
    
    [array addObject:[NSMutableDictionary dictionaryWithObjects:@[kAddRemove,@"Add/Remove Vehicle Defects"] forKeys:@[kTitle,kValue]]];
        
        [tableDataArray addObject:array];
    }

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backBtnClciked:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark:- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict=[[tableDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([[dict objectForKey:kTitle] isEqualToString:kSignature]) {
        return 160;
    }else if ([[dict objectForKey:kTitle] isEqualToString:kAddRemove]){
        return 50;
    }
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[tableDataArray objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *VIRCellID = @"InspectLogVIRCell";
    static NSString *DefectCellID = @"InspectLogDefectCell";
    static NSString *SignatureCellID = @"InspectLogSignatureCell";
    static NSString *AddRemoveCellID = @"InspectLogAddCell";
    NSDictionary *dict=[[tableDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([[dict objectForKey:kTitle] isEqualToString:kVIR]) {
        InspectLogVIRCell *virCell=[tableView dequeueReusableCellWithIdentifier:VIRCellID forIndexPath:indexPath];
        virCell.virIDLabel.text=[SCUIUtility validateString:[dict objectForKey:kValue]];
        virCell.daySubIDLabel.text=[SCUIUtility validateString:[dict objectForKey:kSubValue]];
        return virCell;
    }else if ([[dict objectForKey:kTitle] isEqualToString:kDefect]){
        InspectLogDefectCell *defectCell=[tableView dequeueReusableCellWithIdentifier:DefectCellID forIndexPath:indexPath];
        defectCell.defectsLabel.text=[SCUIUtility validateString:[dict objectForKey:kValue]];
        defectCell.defectIDLabel.text=[SCUIUtility validateString:[dict objectForKey:kSubValue]];
        defectCell.defectIDSubLabel.text=[SCUIUtility validateString:[dict objectForKey:kSubTitle]];
        if ([[dict objectForKey:kDefectStatus] isEqualToString:kDefectSuccess]) {
            [defectCell.defectBtnOutlet setBackgroundColor:kDriveColor];
            [defectCell.defectBtnOutlet setTitle:@"" forState:UIControlStateNormal];
            defectCell.defectBtnOutlet.layer.cornerRadius=0.0f;
            defectCell.defectBtnOutlet.layer.masksToBounds=YES;
        }else{
            [defectCell.defectBtnOutlet setBackgroundColor:kRedColor];
            [defectCell.defectBtnOutlet setTitle:[SCUIUtility validateString:[dict objectForKey:kDefectCount]] forState:UIControlStateNormal];
            defectCell.defectBtnOutlet.layer.cornerRadius=20.0f;
            defectCell.defectBtnOutlet.layer.masksToBounds=YES;
        }
        return defectCell;
    }else if ([[dict objectForKey:kTitle] isEqualToString:kSignature]){
        InspectLogSignatureCell *signatureCell=[tableView dequeueReusableCellWithIdentifier:SignatureCellID forIndexPath:indexPath];
        signatureCell.driverSignatureDateLabel.text=[SCUIUtility validateString:[dict objectForKey:kValue]];
        signatureCell.mechanicSignatureDateLabel.text=[SCUIUtility validateString:[dict objectForKey:kSubValue]];
        signatureCell.driverSignImgView.image=[SCDataUtility galleryImage:DRIVER_SIGNATURE];
        signatureCell.mechanicSignImgView.image=[SCDataUtility galleryImage:DRIVER_SIGNATURE];
        return signatureCell;
    }else if ([[dict objectForKey:kTitle] isEqualToString:kAddRemove]){
        InspectLogAddCell *addCell=[tableView dequeueReusableCellWithIdentifier:AddRemoveCellID forIndexPath:indexPath];
        [addCell.addBtnOutlet setImage:[UIImage imageNamed:@"PlusIcon"] forState:UIControlStateNormal];
        return addCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[[tableDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
   if ([[dict objectForKey:kTitle] isEqualToString:kAddRemove]){
       DEBUGLOG(@"Add/Remove cell clicked");
   }
}

-(UIView*)tableFooterView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    view.backgroundColor=kWhiteColor;
    
    UIButton *addbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addbtn.frame=CGRectMake(view.frame.size.width-80, 20, 60, 60);
    [addbtn setImage:[UIImage imageNamed:@"AddNewDVIRIcon"] forState:UIControlStateNormal];
    [addbtn addTarget:self action:@selector(btnAddNewDVIRPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addbtn];
    UILabel *addLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 35, view.frame.size.width-90, 30)];
    addLabel.backgroundColor=kClearColor;
    addLabel.text=@"ADD NEW DVIR";
    addLabel.textColor=kGrayColor;
    addLabel.textAlignment=NSTextAlignmentRight;
    addLabel.font=[UIFont boldSystemFontOfSize:20];
    [view addSubview:addLabel];
    return view;
}

- (IBAction)btnAddNewDVIRPressed:(id)sender {
    AddNewDVIRViewController *newDVIRViewController = [kLogsStoryboard instantiateViewControllerWithIdentifier:@"addNewDVIRVC"];
    [self.navigationController pushViewController:newDVIRViewController animated:NO];
}

@end
