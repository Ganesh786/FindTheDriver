//
//  HomeViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 02/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "HomeViewController.h"
//#import "SWRevealViewController.h"

@interface HomeViewController () <SWRevealViewControllerDelegate> {
    SWRevealViewController *revealController;

}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation HomeViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    [self setNavigationBarNameWithNameAttribute:@"Dashboard"];
//    [self setBackBarButtonItem];
    [self loadHomeViewComponents];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [revealController panGestureRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [revealController removePanGestureRecognizer];
}

#pragma mark - User defined methods

- (void)loadHomeViewComponents {
    revealController = [self revealViewController];
    revealController.delegate = self;
    [revealController tapGestureRecognizer];

    UIAppDelegate.revealViewController = self.revealViewController;
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);

    self.revealViewController.toggleAnimationType = SWRevealToggleAnimationTypeEaseOut;
    self.revealViewController.frontViewShadowRadius = 5;
    self.revealViewController.frontViewShadowColor = kGrayColor;
    self.revealViewController.frontViewShadowOffset = CGSizeMake(0, 1.5);
    [self.navigationController.navigationBar setBarTintColor:kNavBarColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
