//
//  AboutUSViewController.m
//  FindTheDriver
//
//  Created by mac on 25/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpView];
}

-(void)setUpView{
    
    self.title=@"About UniCONTROL";
    
    self.logoImgView.image=[UIImage imageNamed:@"Logo"];
    self.logoImgView.backgroundColor=kClearColor;
    
    self.titleLabel.text=@"UniCONTROL";
    self.titleLabel.textColor=kNavBarColor;
    
    self.versionLabel.text=[SCUIUtility getAppVersion];
    self.versionLabel.textColor=kBlackColor;
    
    self.rightsLabel.text=@"Copyright © 2015 TTMS";
    self.rightsLabel.textColor=kGrayColor;
    
    self.textView.text=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\n \n  Visit:www.ttms-us.com";
    self.textView.textColor=kGrayColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
