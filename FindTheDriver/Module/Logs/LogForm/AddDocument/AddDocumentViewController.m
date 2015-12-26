//
//  AddDocumentViewController.m
//  FindTheDriver
//
//  Created by mac on 26/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "AddDocumentViewController.h"
#import "DropDownTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "DocumentZoomViewController.h"

@interface AddDocumentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableArray *tableDataArray;
    UIToolbar *accessoryBar;
    UIDatePicker *datePicker;
    
    UIPickerView *docTypePicker;
    NSArray *pickerArray;
    
    UIView *tableFooterView;
    
    UIImage *docImage;
}

@end

@implementation AddDocumentViewController
@synthesize docTypeString;

#define kTitle  @"Title"
#define kValue  @"Value"
#define kMessage  @"Message"
#define kImage  @"Image"

static NSString *kDocType   = @"Bill of Landing";
static NSString *kDate   = @"12/25/2015";
static NSString *kReferenceNumber   = @"Reference number-Load number or B/L number";
static NSString *kNotes   = @"Notes";

static NSString *kDocTypeMessage =@"Select Document Type";
static NSString *kDateMessage =@"Select Date";
static NSString *kReferenceNumberMessage =@"Enter Reference number-Load number or B/L number";
static NSString *kNotesMessage =@"Enter Notes";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.tintColor=kNavBarColor;
    self.tableView.tintColor=kNavBarColor;
    
    self.navigationItem.title=@"Add Document";
   
    tableDataArray=[[NSMutableArray alloc]init];
    [tableDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[docTypeString,kDocType,kDocTypeMessage,@"Calender"] forKeys:@[kValue,kTitle,kMessage,kImage]]];
    [tableDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[[SCDataUtility getTodayDate:@"MM/dd/yyyy"],kDate,kDateMessage,@"Calender"] forKeys:@[kValue,kTitle,kMessage,kImage]]];
    [tableDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"",kReferenceNumber,kReferenceNumberMessage,@"Calender"] forKeys:@[kValue,kTitle,kMessage,kImage]]];
    [tableDataArray addObject:[NSMutableDictionary dictionaryWithObjects:@[@"",kNotes,kNotesMessage,@"Calender"] forKeys:@[kValue,kTitle,kMessage,kImage]]];
    
    pickerArray=[NSArray arrayWithObjects:@"Bill of Landing",@"Gas Station",@"Accident Photo",@"Citation",@"Scale Ticket",@"Other", nil];
    
    self.saveView.backgroundColor=kNavBarColor;
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView=[self footerView];
}

-(UIView*)footerView{
    if (tableFooterView) {
        [tableFooterView removeFromSuperview];
        tableFooterView=nil;
    }
    tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (docImage != nil)?200:100)];
    tableFooterView.backgroundColor=kClearColor;
    UIImageView *tableFooterImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, tableFooterView.frame.size.width-20, tableFooterView.frame.size.height-20)];
    tableFooterImgView.backgroundColor=kClearColor;
    tableFooterImgView.image=docImage;
    tableFooterImgView.contentMode=UIViewContentModeScaleAspectFit;
    tableFooterImgView.clipsToBounds=YES;
    [tableFooterView addSubview:tableFooterImgView];
    
    UIButton *camBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    camBtn.frame=CGRectMake(tableFooterView.frame.size.width-50, 10, 40, 40);
    [camBtn setImage:[UIImage imageNamed:@"Camera"] forState:UIControlStateNormal];
    [camBtn addTarget:self action:@selector(cameraBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:camBtn];
    
    if (docImage) {
        UIButton *zoomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        zoomBtn.frame=CGRectMake(tableFooterView.frame.size.width-100, 10, 40, 40);
        [zoomBtn setBackgroundImage:[UIImage imageNamed:@"Calender"] forState:UIControlStateNormal];
        [zoomBtn addTarget:self action:@selector(zoomBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [tableFooterView addSubview:zoomBtn];
    }
    
    return tableFooterView;
}

-(void)cameraBtnAction{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil otherButtonTitles:@"Capture",@"Attach", nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Capture"]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.navigationBar.barStyle = UIBarStyleBlackOpaque;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
    if ([buttonTitle isEqualToString:@"Attach"]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.navigationBar.barStyle = UIBarStyleBlackOpaque;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}


#pragma mark UIImagePicker Delegate Methods

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    docImage=[info valueForKey:UIImagePickerControllerOriginalImage];
    [self reloadTableFooterView];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        [self showAlert:@"Ooopss !" message:@"Failed to upload !!"];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)zoomBtnAction{
 
    DocumentZoomViewController *zoomController=[[DocumentZoomViewController alloc]init];
    zoomController.zoomImage=docImage;
    [self.navigationController pushViewController:zoomController animated:NO];
}

-(void)reloadTableFooterView{
    [UIView setAnimationsEnabled:NO];
    [self.tableView beginUpdates];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView=[self footerView];
    [self.tableView endUpdates];
    [UIView setAnimationsEnabled:YES];
}

#pragma mark:-UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *dropDownCustomCellIdentifier=@"DropDownTableViewCell";
    static NSString *cmnTextFieldCellIdentifier=@"TextFieldTableViewCell";
    NSDictionary *dict=[tableDataArray objectAtIndex:indexPath.row];
    if ([[dict objectForKey:kTitle] isEqualToString:kDocType]) {
        DropDownTableViewCell *dropDownCell=[tableView dequeueReusableCellWithIdentifier:dropDownCustomCellIdentifier forIndexPath:indexPath];
        dropDownCell.leftImgView.image=[UIImage imageNamed:[dict objectForKey:kImage]];
        dropDownCell.docTextField.inputView = [self inputViewForStatus];
        dropDownCell.docTextField.inputAccessoryView=[self inputAccessoryViewForStatus];
        dropDownCell.docTextField.text=[dict objectForKey:kValue];
        [dropDownCell.rightBtnOutlet setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        return dropDownCell;
    }
    TextFieldTableViewCell *commonCell=[tableView dequeueReusableCellWithIdentifier:cmnTextFieldCellIdentifier forIndexPath:indexPath];
    commonCell.dateTextField.placeholder=[dict objectForKey:kTitle];
    commonCell.dateTextField.text=[dict objectForKey:kValue];
    commonCell.leftImgView.image=[UIImage imageNamed:[dict objectForKey:kImage]];
    if ([[dict objectForKey:kTitle] isEqualToString:kDate]) {
        commonCell.dateTextField.inputView = [self initializeTextFieldInputView];
        commonCell.dateTextField.inputAccessoryView=[self inputAccessoryViewForStatus];
    }else{
        commonCell.dateTextField.inputView = nil;
        commonCell.dateTextField.inputAccessoryView = nil;
        [commonCell.dateTextField reloadInputViews];
    }
    return commonCell;
    
}


#pragma mark:- Date picker methods

-(UIView*)inputAccessoryViewForStatus{
    if (!accessoryBar) {
        accessoryBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,44)];
        accessoryBar.backgroundColor=kNavBarColor;
        accessoryBar.translucent=YES;
        accessoryBar.barTintColor=kNavBarColor;
        [[UIBarButtonItem appearance]setTintColor:kWhiteColor];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(statusDoneAction:)];
//        [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor} forState:UIControlStateNormal];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [accessoryBar setItems:@[flexibleSpace,doneButton]];
    }
    return accessoryBar;
}

-(UIView*)inputViewForStatus{
    if (!docTypePicker) {
        docTypePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        docTypePicker.backgroundColor=kClearColor;
        docTypePicker.delegate = self;
        docTypePicker.dataSource = self;
    }
    [docTypePicker reloadAllComponents];
    if ([pickerArray containsObject:docTypeString]) {
        NSInteger index=[pickerArray indexOfObject:docTypeString];
        [docTypePicker selectRow:index inComponent:0 animated:NO];
    }
    return docTypePicker;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerArray.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self getPickerSelectedValueForRow:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITextField *textfield =  (UITextField*)[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    textfield.text = [self getPickerSelectedValueForRow:row];
    docTypeString=[self getPickerSelectedValueForRow:row];
}

-(NSString*)getPickerSelectedValueForRow:(NSInteger)row{
    NSString *datePickerTitle = [self getTitleForCurrentTextfield];
    if ([datePickerTitle isEqualToString:kDocType]) {
        return [pickerArray objectAtIndex:row];
    }
    return nil;
}

-(void)statusDoneAction:(id)sender{
    UITextField *textfield =  (UITextField*)[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    NSIndexPath *indexPath = [self indexPathForView:textfield];
    NSString *datePickerTitle=[self getTitleForIndexPath:indexPath];
    if ([datePickerTitle isEqualToString:kDate]) {
        [self dateUpdated:datePicker];
        [self setValueForIndexPath:indexPath withValue:[[self formatter] stringFromDate:[datePicker date]]];
    }else {
        [self setValueForIndexPath:indexPath withValue:[self getPickerSelectedValueForRow:[docTypePicker selectedRowInComponent:0]]];
    }
    [self.tableView focusNextTextField];
}


- (UIView*)initializeTextFieldInputView{
    if (!datePicker) {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        datePicker.datePickerMode = UIDatePickerModeDate;
//        datePicker.maximumDate=[NSDate date];
        datePicker.backgroundColor =kClearColor;
        [datePicker addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    }
    return datePicker;
}

- (void)dateUpdated:(UIDatePicker *)datePick{
    UITextField *textfield =  (UITextField*)[self.tableView TPKeyboardAvoiding_findFirstResponderBeneathView:self.view];
    textfield.text = [[self formatter] stringFromDate:[datePick date]];
}

-(NSDateFormatter*)formatter{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    return dateFormat;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Helper Method

-(NSString*)getTitleForIndexPath:(NSIndexPath*)indexPath
{
    id content = [tableDataArray objectAtIndex:indexPath.row];
    if ([content isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary*)content objectForKey:kTitle];
    }else{
        return (NSString*)content;
    }
}

-(void)setValueForIndexPath:(NSIndexPath*)indexPath withValue:(NSString*)value{
    NSMutableDictionary *content = [tableDataArray objectAtIndex:indexPath.row];
    [content setValue:value forKey:kValue];
}

-(NSString*)getValueForIndexPath:(NSIndexPath*)indexPath{
    id content = [tableDataArray objectAtIndex:indexPath.row];
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
    if ([title isEqualToString:kDate]) {
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

- (IBAction)cancelBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveBtnAction:(id)sender {
    
}

@end
