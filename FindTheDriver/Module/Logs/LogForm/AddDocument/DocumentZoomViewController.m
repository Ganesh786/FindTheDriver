//
//  DocumentZoomViewController.m
//  FindTheDriver
//
//  Created by mac on 26/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "DocumentZoomViewController.h"

@interface DocumentZoomViewController ()

@end

@implementation DocumentZoomViewController
@synthesize zoomImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=kNavBarColor;
    self.navigationController.navigationBar.hidden=YES;
    
    [self setUpInitialView];

}

-(void)setUpInitialView{
    
    containerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    containerView.backgroundColor=kWhiteColor;
    containerView.layer.cornerRadius=10.0f;
    containerView.layer.masksToBounds=YES;
    
    mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, containerView.frame.size.width,containerView.frame.size.height)];
    mainScrollView.backgroundColor=[UIColor clearColor];
    mainScrollView.showsHorizontalScrollIndicator=YES;
    mainScrollView.showsVerticalScrollIndicator=YES;
    mainScrollView.delegate=self;
    mainScrollView.maximumZoomScale=100;
    [containerView addSubview:mainScrollView];
    
    
    mainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
    mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    mainImageView.clipsToBounds = YES;
    mainImageView.image=zoomImage;
    [mainScrollView addSubview:mainImageView];
  
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(mainScrollView.bounds),
                                      CGRectGetMidY(mainScrollView.bounds));
    [self view:mainImageView setCenter:centerPoint];
    
    UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame=CGRectMake(containerView.frame.size.width-35, 20, 25, 25);
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    [containerView addSubview:closeBtn];
    
    [self.view addSubview:containerView];

}

- (void)view:(UIView*)view setCenter:(CGPoint)centerPoint
{
    CGRect vf = view.frame;
    CGPoint co = mainScrollView.contentOffset;
    
    CGFloat x = centerPoint.x - vf.size.width / 2.0;
    CGFloat y = centerPoint.y - vf.size.height / 2.0;
    
    if(x < 0)
    {
        co.x = -x;
        vf.origin.x = 0.0;
    }
    else
    {
        vf.origin.x = x;
    }
    if(y < 0)
    {
        co.y = -y;
        vf.origin.y = 0.0;
    }
    else
    {
        vf.origin.y = y;
    }
    
    view.frame = vf;
    mainScrollView.contentOffset = co;
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return mainImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)sv
{
    UIView* zoomView = [sv.delegate viewForZoomingInScrollView:sv];
    CGRect zvf = zoomView.frame;
    if(zvf.size.width < sv.bounds.size.width)
    {
        zvf.origin.x = (sv.bounds.size.width - zvf.size.width) / 2.0;
    }
    else
    {
        zvf.origin.x = 0.0;
    }
    if(zvf.size.height < sv.bounds.size.height)
    {
        zvf.origin.y = (sv.bounds.size.height - zvf.size.height) / 2.0;
    }
    else
    {
        zvf.origin.y = 0.0;
    }
    zoomView.frame = zvf;
}

-(void)closeBtnAction{
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
