//
//  UINavigationController+Addition.m
//  SkillsConnect
//
//  Created by Dinesh A. Kumar on 07/07/15.
//
//

#import "UINavigationController+Addition.h"

@implementation UINavigationController(Addition)

- (void)navigationBarSetting {
    
    [self.navigationBar setBarTintColor:kNavBarColor];
    (self.navigationBar).titleTextAttributes = @{NSForegroundColorAttributeName:kWhiteColor};
    
}

@end
