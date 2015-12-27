//
//  LogFormViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "LogFormViewController.h"
#import "DefaultLabelCell.h"
#import "StartTimeCell.h"
#import "ShippingCell.h"
#import "AddDocumentViewController.h"
@interface LogFormViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    NSMutableArray *tableDriverDataArray;
    NSMutableArray *tableTimeDataArray;
    NSMutableArray *tableShippingDataArray;
    NSIndexPath *selectedIndexPath;
    BOOL editData;
    UITextField *selectedLocationTextField;

}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@end

@implementation LogFormViewController

#define kTitle  @"Title"
#define kValue  @"Value"
#define kMessage  @"Message"

#define kOdoMeter  @"OdoMeter"

static NSString *kDriver   = @"Driver";
static NSString *kCoDriver   = @"Co-Driver";
static NSString *kVehicle   = @"Vehicle";
static NSString *kCarrier   = @"Carrier";

static NSString *kDriverMessage   = @"Driver";
static NSString *kCoDriverMessage   = @"Co-Driver";
static NSString *kVehicleMessage   = @"Vehicle";
static NSString *kCarrierMessage   = @"Carrier";

static NSString *kStart   = @"Start";
static NSString *kEnd   = @"End";

static NSString *kStartMessage   = @"Start";
static NSString *kEndMessage   = @"End";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.tintColor=kNavBarColor;
    self.tableView.tintColor=kNavBarColor;
    
    editData=NO;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editMode)];
    
    tableDriverDataArray=[[NSMutableArray alloc]init];
    tableTimeDataArray=[[NSMutableArray alloc]init];
    tableShippingDataArray=[[NSMutableArray alloc]init];
    [self setUpView];
}

-(void)setUpView{
    
    [tableDriverDataArray removeAllObjects];
    [tableTimeDataArray removeAllObjects];
    [tableShippingDataArray removeAllObjects];

    [tableDriverDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"Shreeshail",kDriver,kDriverMessage] forKeys:@[kValue,kTitle,kMessage]]];
    [tableDriverDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"S Ganachari",kCoDriver,kCoDriverMessage] forKeys:@[kValue,kTitle,kMessage]]];
    [tableDriverDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"KA 28 F 444",kVehicle,kVehicleMessage] forKeys:@[kValue,kTitle,kMessage]]];
    [tableDriverDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"TTMS",kCarrier,kCarrierMessage] forKeys:@[kValue,kTitle,kMessage]]];
    
    [tableTimeDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"Bangalore",kStart,kStartMessage,@"48344"] forKeys:@[kValue,kTitle,kMessage,kOdoMeter]]];
    [tableTimeDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"Mysore",kEnd,kEndMessage,@"33444"] forKeys:@[kValue,kTitle,kMessage,kOdoMeter]]];
    
    [tableShippingDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"Bill of Landing",@"BillLand"] forKeys:@[kValue,kTitle]]];
    [tableShippingDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"Gas Station",@"GasStation"] forKeys:@[kValue,kTitle]]];
    
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}

-(void)cancelMode{
    editData=NO;
    self.tabBarController.tabBar.hidden=NO;
    self.navigationItem.rightBarButtonItem=nil;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editMode)];
    [self setUpView];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"Monday | October 10";
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.title=@"";
}

-(void)editMode{
    editData=YES;
    self.tabBarController.tabBar.hidden=YES;
    self.navigationItem.rightBarButtonItem=nil;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveMode)];
    [self.tableView reloadData];
}

- (void)saveMode{
    editData=NO;
    self.tabBarController.tabBar.hidden=NO;
    self.navigationItem.rightBarButtonItem=nil;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editMode)];
    [self.tableView reloadData];
    
    //Save Data
}

- (IBAction)backBtnClicked:(id)sender {
    if (editData) {
        [self cancelMode];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}


#pragma mark:-UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return tableDriverDataArray.count;
            break;
        case 1:
            return tableTimeDataArray.count;
            break;
        case 2:
            return tableShippingDataArray.count;
            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2 && tableShippingDataArray.count >0) {
        return 50;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
        headerView.backgroundColor=[UIColor clearColor];
        UILabel *headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, headerView.frame.size.width-40, 30)];
        headerLabel.textColor=kGrayColor;
        headerLabel.textAlignment=NSTextAlignmentLeft;
        headerLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
        headerLabel.numberOfLines=1;
        headerLabel.adjustsFontSizeToFitWidth=YES;
        headerLabel.contentScaleFactor=0.8;
        headerLabel.text=@"Shipping documents";
        [headerView addSubview:headerLabel];
        if (editData) {
            UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame=CGRectMake(headerView.frame.size.width-35, 10, 30, 30);
            [addBtn setImage:[UIImage imageNamed:@"AddIcon"] forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(addNewShippingDocument) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:addBtn];
        }
        return headerView;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defaultCellIdentifier=@"DefaultLabelCell";
    static NSString *timerCellIdentifier=@"StartTimeCell";
    static NSString *shippingCellIdentifier=@"ShippingCell";
    switch (indexPath.section) {
        case 0:{
            DefaultLabelCell *cell=[tableView dequeueReusableCellWithIdentifier:defaultCellIdentifier forIndexPath:indexPath];
            cell.leftLabel.text=[[tableDriverDataArray objectAtIndex:indexPath.row] objectForKey:kTitle];
            cell.rightTextField.placeholder=[NSString stringWithFormat:@"Enter %@",[[tableDriverDataArray objectAtIndex:indexPath.row] objectForKey:kTitle]];
            cell.rightTextField.text=[[tableDriverDataArray objectAtIndex:indexPath.row] objectForKey:kValue];
            cell.rightTextField.enabled=editData;
            return cell;
        }break;
        case 1:{
            StartTimeCell *cell=[tableView dequeueReusableCellWithIdentifier:timerCellIdentifier forIndexPath:indexPath];
            cell.startLabel.text=[[tableTimeDataArray objectAtIndex:indexPath.row] objectForKey:kTitle];
            [cell.locationBtnOutlet addTarget:self action:@selector(getCurrentLocation:) forControlEvents:UIControlEventTouchUpInside];
            cell.locationTextField.placeholder=@"Location";
            cell.odometerTextField.placeholder=@"Odometer Reading";
            cell.locationTextField.text=[[tableTimeDataArray objectAtIndex:indexPath.row] objectForKey:kValue];
            cell.odometerTextField.text=[[tableTimeDataArray objectAtIndex:indexPath.row] objectForKey:kOdoMeter];
            cell.odometerMeasureLabel.text=[SCDataUtility getSelectedOdometer];
            return cell;
        }break;
        case 2:{
            ShippingCell *cell=[tableView dequeueReusableCellWithIdentifier:shippingCellIdentifier forIndexPath:indexPath];
            cell.shippingImgView.image=[UIImage imageNamed:[[tableShippingDataArray objectAtIndex:indexPath.row] objectForKey:kTitle]];
            cell.shippingLabel.text=[[tableShippingDataArray objectAtIndex:indexPath.row] objectForKey:kValue];
            return cell;
        }break;
        default:
            return nil;
            break;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && editData) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && indexPath.section == 2 && editData) {
        selectedIndexPath=indexPath;
        DeleteDocumentView *docView=[[DeleteDocumentView alloc]initWithFrame:self.view.frame];
        docView.delegate=self;
        [self.navigationController.view addSubview:docView];
    }
}

-(void)deleteDocumentConfirmed{
    [tableShippingDataArray removeObjectAtIndex:selectedIndexPath.row];
    NSMutableArray *indexpaths = [NSMutableArray array];
    [indexpaths addObject:[NSIndexPath indexPathForRow:selectedIndexPath.row inSection:selectedIndexPath.section]];
    [self.tableView deleteRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationFade];
}

-(void)deleteDocumentCancelled{
    [self.tableView setEditing:NO animated:YES];
}

-(void)addNewShippingDocument{
    AddDocumentView *docView=[[AddDocumentView alloc]initWithFrame:self.view.frame];
    docView.delegate=self;
    [self.navigationController.parentViewController.view addSubview:docView];
}

-(void)selectedDocumentType:(NSString*)docType{
    DEBUGLOG(@"docType->%@",docType);
    
    AddDocumentViewController *docViewController=[kLogsStoryboard instantiateViewControllerWithIdentifier:@"AddDocumentViewController"];
    docViewController.docTypeString=docType;
    [self.navigationController pushViewController:docViewController animated:YES];
}

-(void)getCurrentLocation:(UIButton *)sender{
    if (editData && !self.locationFinder) {
        self.locationFinder = [[CurrentLocation alloc] init];
        self.locationFinder.delegate = self;
        [self.locationFinder.locationManager startUpdatingLocation];
        if ([self.locationFinder.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [self.locationFinder.locationManager requestAlwaysAuthorization];
        }
        UIButton *button = (UIButton*)sender;
        NSIndexPath *indexPath = [self indexPathForView:button];
        StartTimeCell  *cell = (StartTimeCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        selectedLocationTextField=cell.locationTextField;
//        [cell.locationTextField becomeFirstResponder];
    }
}

#pragma mark:- CoreLocationFinderDelegate
- (void)locationError:(NSError *)error
{
    DEBUGLOG(@"error while updating location --%@", [error description]);
    self.locationFinder=nil;
}

-(void)update:(CLLocation *)location{
    CLLocation *currentLocation=location;
    if (nil != currentLocation) {
        if (!geoCoder)
            geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:location completionHandler:
         ^(NSArray* placemarks, NSError* error)
         {
             if ([placemarks count] > 0)
             {
                 placemark = [placemarks objectAtIndex:0];
                 NSString  *address = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",
                                       placemark.subThoroughfare,
                                       placemark.thoroughfare,
                                       placemark.postalCode,
                                       placemark.locality,
                                       placemark.subLocality,
                                       placemark.subAdministrativeArea,
                                       placemark.administrativeArea,
                                       placemark.country];
                 DEBUGLOG(@"adress = %@",address);
                 selectedLocationTextField.text=[SCUIUtility validateString:placemark.locality];
                 [self resignKeyBoard];
             }
             [self.locationFinder.locationManager stopUpdatingLocation];
             self.locationFinder=nil;
         }];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Helper Method

-(NSString*)getTitleForIndexPath:(NSIndexPath*)indexPath
{
    id content;
    switch (indexPath.section) {
        case 0:
            content=[tableDriverDataArray objectAtIndex:indexPath.row];
            break;
        case 1:
            content =[tableTimeDataArray objectAtIndex:indexPath.row];
            break;
        case 2:
            content=[tableShippingDataArray objectAtIndex:indexPath.row];
            break;
        default:
            content=nil;
            break;
    }
    if ([content isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary*)content objectForKey:kTitle];
    }else{
        return (NSString*)content;
    }
}

-(void)setValueForIndexPath:(NSIndexPath*)indexPath withValue:(NSString*)value{
    id content;
    switch (indexPath.section) {
        case 0:
            content=[tableDriverDataArray objectAtIndex:indexPath.row];
            break;
        case 1:
            content =[tableTimeDataArray objectAtIndex:indexPath.row];
            break;
        case 2:
            content=[tableShippingDataArray objectAtIndex:indexPath.row];
            break;
        default:
             content=nil;
            break;
    }
    [content setValue:value forKey:kValue];
}

-(NSString*)getValueForIndexPath:(NSIndexPath*)indexPath{
    id content;
    switch (indexPath.section) {
        case 0:
            content=[tableDriverDataArray objectAtIndex:indexPath.row];
            break;
        case 1:
            content =[tableTimeDataArray objectAtIndex:indexPath.row];
            break;
        case 2:
            content=[tableShippingDataArray objectAtIndex:indexPath.row];
            break;
        default:
            content=nil;
            break;
    }
    if ([content isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary*)content objectForKey:kValue];
    }else{
        return (NSString*)content;
    }
}

-(NSIndexPath*)indexPathForView:(UIView*)view{
    while (view && ![view isKindOfClass:[UITableViewCell class]])
        view = view.superview;
    return [self.tableView indexPathForRowAtPoint:view.center];
}

-(NSString*)getTitleForCurrentTextfield{
    UITextField *textfield =  (UITextField*)[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    NSIndexPath *indexPath = [self indexPathForView:textfield];
    return [self getTitleForIndexPath:indexPath];
}

#pragma mark:-UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSIndexPath *indexPath = [self indexPathForView:textField];
    NSString *title = [self getTitleForIndexPath:indexPath];
    if ([title isEqualToString:kStart]) {
        //Start Locations
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSIndexPath *indexPath = [self indexPathForView:textField];
    [self setValueForIndexPath:indexPath withValue:textField.text];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self.tableView focusNextTextField]) {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)resignKeyBoard{
    [[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view] resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
