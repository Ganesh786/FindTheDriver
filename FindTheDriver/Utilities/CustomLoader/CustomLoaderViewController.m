//
//  CustomLoaderViewController.m
//  FindTheDriver
//
//  Created by mac on 18/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "CustomLoaderViewController.h"

@interface CustomLoaderViewController (){
    UIImageView *blueArc;
    UIImageView *redArc;
}
@end

@implementation CustomLoaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor clearColor];

    [self setUpView];
}

-(void)setUpView{
    
    int logoWidth=100;
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-logoWidth)/2, ([[UIScreen mainScreen]bounds].size.height-logoWidth)/2, logoWidth, logoWidth)];
    [logo setImage:[UIImage imageNamed:@"topCheck"]];
    [self.view addSubview:logo];
    int arcWidth=logoWidth+logoWidth/2;
    blueArc = [[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-arcWidth)/2, ([[UIScreen mainScreen]bounds].size.height-arcWidth)/2, arcWidth, arcWidth)];
    blueArc.backgroundColor = [UIColor clearColor];
    [blueArc setImage:[UIImage imageNamed:@"blueArc.png"]];
    [self.view addSubview:blueArc];

   /*
    redArc = [[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-100)/2, ([[UIScreen mainScreen]bounds].size.height-100)/2, 100, 100)];
    [redArc setImage:[UIImage imageNamed:@"redArc.png"]];
    redArc.backgroundColor = [UIColor clearColor];
    [self.view addSubview:redArc];
    */
    [self animateViews];
}


-(void)animateViews{
    CABasicAnimation *fullRotation;
    fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    //fullRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    fullRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)]; // added this minus sign as i want to rotate it to anticlockwise
    fullRotation.duration = 1.0f;
    fullRotation.speed = 0.5f;              // Changed rotation speed
    fullRotation.repeatCount = MAXFLOAT;
    
    [blueArc.layer addAnimation:fullRotation forKey:@"Blue"];
 /*
    CABasicAnimation *redRotation;
    redRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    redRotation.fromValue = [NSNumber numberWithFloat:0];
    //redRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    redRotation.toValue = [NSNumber numberWithFloat:(2*M_PI)]; // added this minus sign as i want to rotate it to anticlockwise
    redRotation.duration = 2.0f;
    redRotation.speed = 1.2f;              // Changed rotation speed
    redRotation.repeatCount = MAXFLOAT;
    
    [redArc.layer addAnimation:redRotation forKey:@"Red"];
  */
}

- (void)stopAllAnimations
{
    [blueArc.layer removeAllAnimations];
//    [redArc.layer removeAllAnimations];
};

- (void)pauseAnimations
{
    
    [self pauseLayer:blueArc.layer];
//    [self pauseLayer:redArc.layer];
    
}

- (void)resumeAnimations
{
    
    [self resumeLayer:blueArc.layer];
//    [self resumeLayer:redArc.layer];
}

- (void)pauseLayer:(CALayer *)layer
{
    
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer *)layer
{
    
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

-(void)dealloc{
    [self stopAllAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
