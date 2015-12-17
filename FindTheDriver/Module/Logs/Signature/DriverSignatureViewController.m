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

@interface DriverSignatureViewController () {
    NSArray *nameArray, *imagesArray;
    CGPoint lastPoint;
    BOOL mouseSwiped;
    int mouseMoved;
}

@property (weak, nonatomic) IBOutlet UIButton *previewLogBtn;
@property (weak, nonatomic) IBOutlet UIButton *addSignatureBtn;
@property (weak, nonatomic) IBOutlet UITableView *actionTblView;
@property (weak, nonatomic) IBOutlet UINavigationItem *signatureNavigationItem;
@property (weak, nonatomic) IBOutlet UIView *signatureBGView;
@property (weak, nonatomic) IBOutlet UIImageView *signatureImgView;
@property (nonatomic, assign) int tapCount;

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
    _actionTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _signatureNavigationItem.title = @"Monday | October 10";
    _signatureBGView.hidden = YES;
    
    mouseMoved = 0;
    self.tapCount = 0;
}

#pragma mark - User Action Methods

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)touchAndSignatureBtnClicked:(id)sender {
    _signatureBGView.hidden = NO;
    _addSignatureBtn.hidden = YES;
}

- (IBAction)previewLogBtnClicked:(id)sender {
    [UIAlertView showAlertViewWithTitle:@"" Message:kComingSoon];
}

- (IBAction)closeBtnClicked:(id)sender {
    _signatureBGView.hidden = YES;
    _addSignatureBtn.hidden = NO;
    _signatureImgView.image = nil;
}

#pragma mark - UITouch delegate methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tapCount = 0;
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    
    lastPoint = [touch locationInView:self.view];
    lastPoint.y -= 20;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    currentPoint.y -= 20;
    UIGraphicsBeginImageContext(self.view.frame.size);
    [_signatureImgView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextRef bluecontext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(bluecontext, 3.0);
    CGContextSetStrokeColorWithColor(bluecontext, [UIColor blackColor].CGColor);
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _signatureImgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    lastPoint = currentPoint;
    mouseMoved++;
    if (mouseMoved == 10) {
        mouseMoved = 0;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [_signatureImgView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        
        CGContextRef bluecontext = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(bluecontext, 3.0);
        CGContextSetStrokeColorWithColor(bluecontext, [UIColor blackColor].CGColor);
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.signatureImgView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
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
