//
//  InspectLogsViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 13/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "InspectLogsViewController.h"
#import "InspectLogsCustomTableViewCell.h"

@interface InspectLogsViewController ()
{
    BOOL fingerMoved;
    NSMutableArray *defectsArray;
    CGPoint lastContactPoint1, lastContactPoint2, currentPoint;
    CGRect imageFrame;
}
@end

@implementation InspectLogsViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    defectsArray = [NSMutableArray array];
    self.title = @"Monday | October 10";
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
    imageFrame = _driverSignatureView.frame;
    _driverSignatureView.backgroundColor = [UIColor lightGrayColor];
    _mechanicSignatureView.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //did our finger moved yet?
    fingerMoved = NO;
    UITouch *touch = [touches anyObject];
    
    if ([touch tapCount] == 2) {
        _driverSignatureView.image = nil;
        return;
    }
    
    //we need 3 points of contact to make our signature smooth using quadratic bezier curve
    currentPoint = [touch locationInView:_driverSignatureView];
    lastContactPoint1 = [touch previousLocationInView:_driverSignatureView];
    lastContactPoint2 = [touch previousLocationInView:_driverSignatureView];
    
}


//when one or more fingers associated with an event move within a view or window
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //well its obvious that our finger moved on the screen
    fingerMoved = YES;
    UITouch *touch = [touches anyObject];
    
    //save previous contact locations
    lastContactPoint2 = lastContactPoint1;
    lastContactPoint1 = [touch previousLocationInView:_driverSignatureView];
    //save current location
    currentPoint = [touch locationInView:_driverSignatureView];
    
    //find mid points to be used for quadratic bezier curve
    CGPoint midPoint1 = [self midPoint:lastContactPoint1 withPoint:lastContactPoint2];
    CGPoint midPoint2 = [self midPoint:currentPoint withPoint:lastContactPoint1];
    
    //create a bitmap-based graphics context and makes it the current context
    UIGraphicsBeginImageContext(imageFrame.size);
    
    //draw the entire image in the specified rectangle frame
    [_driverSignatureView.image drawInRect:CGRectMake(0, 0, imageFrame.size.width, imageFrame.size.height)];
    
    //set line cap, width, stroke color and begin path
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0f);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    //begin a new new subpath at this point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), midPoint1.x, midPoint1.y);
    //create quadratic Bézier curve from the current point using a control point and an end point
    CGContextAddQuadCurveToPoint(UIGraphicsGetCurrentContext(),
                                 lastContactPoint1.x, lastContactPoint1.y, midPoint2.x, midPoint2.y);
    
    //set the miter limit for the joins of connected lines in a graphics context
    CGContextSetMiterLimit(UIGraphicsGetCurrentContext(), 2.0);
    
    //paint a line along the current path
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    //set the image based on the contents of the current bitmap-based graphics context
    _driverSignatureView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //remove the current bitmap-based graphics context from the top of the stack
    UIGraphicsEndImageContext();
    
    //lastContactPoint = currentPoint;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    //just clear the image if the user tapped twice on the screen
    if ([touch tapCount] == 2) {
        _driverSignatureView.image = nil;
        return;
    }
    
    
    //if the finger never moved draw a point
    if(!fingerMoved) {
        UIGraphicsBeginImageContext(imageFrame.size);
        [_driverSignatureView.image drawInRect:CGRectMake(0, 0, imageFrame.size.width, imageFrame.size.height)];
        
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0f);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        
        _driverSignatureView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

- (CGPoint) midPoint:(CGPoint )p0 withPoint: (CGPoint) p1 {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}
- (IBAction)btnAddNewDVIRPressed:(id)sender {
}
@end
