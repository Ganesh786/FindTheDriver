//
//  CustomLogSearchViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 05/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "CustomLogSearchViewController.h"

@interface CustomLogSearchViewController ()
@property (weak, nonatomic) IBOutlet UIView *logFilterView;

@end

@implementation CustomLogSearchViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //slide in the filter view from the bottom
    [self slideIn];
}

#pragma mark - User defained methods

- (void)slideIn {
    
    //set initial location at bottom of view
    CGRect frame = self.logFilterView.frame;
    frame.origin = CGPointMake(0.0, self.view.bounds.size.height);
    self.logFilterView.frame = frame;
    [self.view addSubview:self.logFilterView];
    
    //animate to new location, determined by height of the view in the NIB
    [UIView beginAnimations:@"presentWithSuperview" context:nil];
    frame.origin = CGPointMake(0.0, self.view.bounds.size.height - self.logFilterView.bounds.size.height);
    
    self.logFilterView.frame = frame;
    [UIView commitAnimations];
}

- (void) slideOut {
    
    //do what you need to do with information gathered from the custom action sheet. E.g., apply data filter on parent view.
    
    [UIView beginAnimations:@"removeFromSuperviewWithAnimation" context:nil];
    
    // Set delegate and selector to remove from superview when animation completes
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:)];
    
    // Move this view to bottom of superview
    CGRect frame = self.logFilterView.frame;
    frame.origin = CGPointMake(0.0, self.view.bounds.size.height);
    self.logFilterView.frame = frame;
    
    [UIView commitAnimations];
}

// Method called when removeFromSuperviewWithAnimation's animation completes
- (void)animationDidStop:(NSString *)animationID {
    if ([animationID isEqualToString:@"removeFromSuperviewWithAnimation"]) {
        [self.view removeFromSuperview];
//        if (checkedString!=nil)
//            [self.cellSelectorDelegate didMakeCellSelectionName:checkedString WithId:[self.actionSheetDataSourceDict valueForKey:checkedString] ascOrDesc:ascOrDesc WithDelegateName:@"Sort"];
    }
}

#pragma mark - User action methods

- (IBAction)transparentBtnClicked:(id)sender {
    [self slideOut];
}

- (IBAction)calendarBtnClicked:(id)sender {
    [self slideOut];
}

- (IBAction)doneBtnClicked:(id)sender {
    
}

- (IBAction)clearBtnClicked:(id)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
