//
//  CustomLoaderView.m
//  FindTheDriver
//
//  Created by mac on 20/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "CustomLoaderView.h"
#import "DACircularProgressView.h"

@interface CustomLoaderView (){
    DACircularProgressView *progressView;
    CGFloat progress;
}
@end

@implementation CustomLoaderView

+(CustomLoaderView*)sharedView{
    static CustomLoaderView *sharedView=nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedView=[[CustomLoaderView alloc]initWithFrame:[[UIScreen mainScreen]bounds] loaderHt:100];
    });
    return sharedView;
}
- (id)initWithFrame:(CGRect)frame loaderHt:(NSInteger)loaderHt{
    self = [super initWithFrame:frame];
    if (self){
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(progressChange)userInfo:nil repeats:YES];
        progressView = [[DACircularProgressView alloc]initWithFrame:CGRectMake((frame.size.width-loaderHt)/2, (frame.size.height-loaderHt)/2, loaderHt, loaderHt)];
        progressView.roundedCorners = YES;
        progressView.progressTintColor=kNavBarColor;
        progressView.backgroundColor=kClearColor;
        progressView.trackTintColor=kGrayColor;
        progressView.userInteractionEnabled=NO;
        [self addSubview:progressView];
        UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake((progressView.frame.size.width-90)/2, (progressView.frame.size.height-90)/2, 90, 90)];
        [logo setImage:[UIImage imageNamed:@"topCheck"]];
        [progressView addSubview:logo];
    }
    return self;
}
-(void)showLoader{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            [window addSubview:self];
            break;
        }
    }
}

- (void)progressChange
{
    progress+=0.1f;
    if (progress >= (float)1.2) {
        progress=0.0f;
    }
    [progressView setProgress:progress animated:YES];
}

-(void)dismissLoader{
    [self removeFromSuperview];
}
@end
