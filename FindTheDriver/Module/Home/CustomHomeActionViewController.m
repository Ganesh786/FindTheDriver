//
//  CustomHomeActionViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 10/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "CustomHomeActionViewController.h"

@interface CustomHomeActionViewController ()
@property (weak, nonatomic) IBOutlet UIView *actionView;

@end

@implementation CustomHomeActionViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self slideIn];
}

#pragma mark - User defined methods

- (void)slideIn {
    
    //set initial location at bottom of view
    CGRect frame = self.actionView.frame;
    frame.origin = CGPointMake(0.0, self.view.bounds.size.height);
    self.actionView.frame = frame;
    [self.view addSubview:self.actionView];
    
    //animate to new location, determined by height of the view in the NIB
    [UIView beginAnimations:@"presentWithSuperview" context:nil];
    frame.origin = CGPointMake(0.0, self.view.bounds.size.height - self.actionView.bounds.size.height);
    
    self.actionView.frame = frame;
    [UIView commitAnimations];
}

- (void) slideOut {
    
    //do what you need to do with information gathered from the custom action sheet. E.g., apply data filter on parent view.
    
    [UIView beginAnimations:@"removeFromSuperviewWithAnimation" context:nil];
    
    // Set delegate and selector to remove from superview when animation completes
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:)];
    
    // Move this view to bottom of superview
    CGRect frame = self.actionView.frame;
    frame.origin = CGPointMake(0.0, self.view.bounds.size.height);
    self.actionView.frame = frame;
    
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

- (IBAction)driverStatusActionBtnClicked:(id)sender {
    [self slideOut];

    UIButton *btn = sender;
    switch (btn.tag) {
        case 1:
            DEBUGLOG(@"Off duty btn clicked");
            break;
        case 2:
            DEBUGLOG(@"sleper btn clicked");
            break;
        case 3:
            DEBUGLOG(@"driving btn clicked");
            break;
        case 4:
            DEBUGLOG(@"on duty btn clicked");
            break;
            
        default:
            break;
    }
}

- (IBAction)transparentBtnClicked:(id)sender {
    [self slideOut];
}

- (IBAction)changeStatusBtnClicked:(id)sender {
    [self slideOut];
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
