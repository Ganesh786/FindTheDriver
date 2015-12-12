//
//  TodayLogViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 12/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "TodayLogViewController.h"

@interface TodayLogViewController ()

@end

@implementation TodayLogViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTodayViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadTodayViewComponents {
    self.navigationItem.title = @"gani";
    [self setBackBarButtonItem];
//    [self setNavigationBarNameWithNameAttribute:@"Monday | October 10"];
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
