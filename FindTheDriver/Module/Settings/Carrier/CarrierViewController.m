//
//  CarrierViewController.m
//  FindTheDriver
//
//  Created by Prajoth Antonio D'sa on 09/12/15.
//  Copyright © 2015 PADStudios. All rights reserved.
//

#import "CarrierViewController.h"

@interface CarrierViewController ()

@end

@implementation CarrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)btnEditPressed:(id)sender
{
    [self animateView:_lblHomeAddress withHidden:YES];
    [self animateView:_btnEdit withHidden:YES];
    [self animateView:_viewAddressEdit withHidden:NO];
    [self animateView:_btnSave withHidden:NO];
    [self animateView:_btnCancel withHidden:NO];
    
    [self stylizeTextFields];
    _txtAddressEdit1.text = @"1995 W. 190th St";
    _txtAddressEdit2.text = @"Suite 200";
    _txtAddressEdit3.text = @"Torrance, CA 90504";
}

- (IBAction)btnSaveClicked:(id)sender {
    [self animateView:_lblHomeAddress withHidden:NO];
    [self animateView:_btnEdit withHidden:NO];
    [self animateView:_viewAddressEdit withHidden:YES];
    [self animateView:_btnSave withHidden:YES];
    [self animateView:_btnCancel withHidden:YES];
}

- (IBAction)btnCancelClicked:(id)sender {
    [self animateView:_lblHomeAddress withHidden:NO];
    [self animateView:_btnEdit withHidden:NO];
    [self animateView:_viewAddressEdit withHidden:YES];
    [self animateView:_btnSave withHidden:YES];
    [self animateView:_btnCancel withHidden:YES];
}

- (void) stylizeTextFields
{
    NSMutableArray *textFields = [[NSMutableArray alloc]initWithObjects:_txtAddressEdit1, _txtAddressEdit2, _txtAddressEdit3, nil];
    for (UITextField *txtField in textFields)
    {
        CALayer *border = [CALayer layer];
        CGFloat borderWidth = 1;
        border.borderColor = [UIColor colorFromHexString:@"#DDE2E5"].CGColor;
        border.frame = CGRectMake(0, txtField.frame.size.height - borderWidth, txtField.frame.size.width, txtField.frame.size.height);
        border.borderWidth = borderWidth;
        [txtField.layer addSublayer:border];
        [txtField setBorderStyle:UITextBorderStyleNone];
        [txtField setNeedsDisplay];
        txtField.layer.masksToBounds = YES;
    }
}

- (void)animateView:(UIView*)view withHidden:(BOOL)hidden
{
    [UIView transitionWithView:view
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    view.hidden = hidden;
}
@end