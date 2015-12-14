//
//  UIViewController+Additions.m
//  SkillsConnect
//
//  Created by Ganesh Korada on 06/11/14.
//
//

#import "UIViewController+Additions.h"
#import "UIColor+Additions.h"

@implementation UIViewController (Additions)

- (void)setLayoutViewAnimationWithView:(UIView *)layoutView OriginX:(float)xValue OriginY:(float )yValue {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    layoutView.frame = CGRectMake(xValue, yValue, layoutView.frame.size.width, layoutView.frame.size.height);
    [UIView commitAnimations];
}

- (void)addGestureRecognizerToHideTheKeyboardWithView:(UIView *)view {
    UITapGestureRecognizer *viewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [view addGestureRecognizer:viewTapRecognizer];
}

- (void)hideKeyboard:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self setLayoutViewAnimationWithView:self.view OriginX:0 OriginY:0];
    [self setLayoutViewAnimationWithView:self.navigationController.view OriginX:0 OriginY:0];
}

- (void)setNavigationBarNameWithNameAttribute:(NSString *)navTitle {
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName: kWhiteColor,
                                    NSBackgroundColorAttributeName: kWhiteColor,
                                    NSFontAttributeName: [UIFont fontWithName:kHelveticaNeueFontName size:17]};
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.title = navTitle;
}

- (void)setBackBarButtonItem {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}

- (CAShapeLayer *)getLineBorderLayerWithColorCode:(NSString *)colorCode {
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor colorFromHexString:colorCode].CGColor;
    border.fillColor = nil;
    border.lineDashPattern = @[@4, @2];

    return border;
}

-(void)showAlert:(NSString*)title message:(NSString*)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction: ok];
    id rootViewController=[UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[UINavigationController class]])
    {
        rootViewController=[((UINavigationController *)rootViewController).viewControllers objectAtIndex:0];
    }
    [rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
