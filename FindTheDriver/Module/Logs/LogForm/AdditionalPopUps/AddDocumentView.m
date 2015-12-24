//
//  AddDocumentView.m
//  FindTheDriver
//
//  Created by mac on 24/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "AddDocumentView.h"

@implementation AddDocumentView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor colorWithRed:0.200f green:0.200f blue:0.200f alpha:0.5f];
        
        textDataArray=[NSArray arrayWithObjects:@"Bill of Landing",@"Gas Station",@"Accident Photo",@"Citation",@"Scale Ticket",@"Other", nil];
        imageDataArray=[NSArray arrayWithObjects:@"Calender",@"Calender",@"Calender",@"Calender",@"Calender",@"Calender", nil];
        
        UIView *popUp=[[UIView alloc]initWithFrame:CGRectMake(10, (frame.size.height-300)/2, frame.size.width-20, 300)];
        popUp.backgroundColor=kWhiteColor;
        popUp.layer.cornerRadius=10.0f;
        popUp.layer.masksToBounds=YES;
        [self addSubview:popUp];
        
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, popUp.frame.size.width, 50)];
        topView.backgroundColor=kNavBarColor;
        UILabel *headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, topView.frame.size.width-40, 30)];
        headerLabel.textColor=kWhiteColor;
        headerLabel.textAlignment=NSTextAlignmentCenter;
        headerLabel.font=[UIFont boldSystemFontOfSize:20];
        headerLabel.numberOfLines=1;
        headerLabel.adjustsFontSizeToFitWidth=YES;
        headerLabel.contentScaleFactor=0.8;
        headerLabel.text=@"ADD DOCUMENT";
        [topView addSubview:headerLabel];
        UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame=CGRectMake(topView.frame.size.width-35, 10, 30, 30);
        [addBtn setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(closePopUP) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:addBtn];
        [popUp addSubview:topView];
        
        UIView *containerView=[[UIView alloc]initWithFrame:CGRectMake(0, topView.frame.size.height, popUp.frame.size.width, popUp.frame.size.height-50)];
        containerView.backgroundColor=kClearColor;
        [popUp addSubview:containerView];
        
        int xAxis=0;
        int yAxis=0;
        int counter=1;
        
        int containerWidth=containerView.frame.size.width/3;
        int containerHeight=containerView.frame.size.height/2;

        for (int i=0; i<textDataArray.count; i++) {
            
            UIView *gridView=[[UIView alloc]initWithFrame:CGRectMake(xAxis, yAxis, containerWidth, containerHeight)];
            gridView.backgroundColor=kClearColor;
            [containerView addSubview:gridView];

            UIButton *docBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            docBtn.frame=CGRectMake((gridView.frame.size.width-80)/2, 10, 80, 80);
            [docBtn addTarget:self action:@selector(docTypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [docBtn setBackgroundImage:[UIImage imageNamed:[imageDataArray objectAtIndex:i]] forState:UIControlStateNormal];
            docBtn.tag=i;
            [gridView addSubview:docBtn];

            UILabel *docLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,docBtn.frame.size.height+docBtn.frame.origin.y, gridView.frame.size.width-10, 40)];
            docLabel.textColor=kGrayColor;
            docLabel.textAlignment=NSTextAlignmentCenter;
            docLabel.backgroundColor=kClearColor;
            docLabel.font=[UIFont boldSystemFontOfSize:16];
            docLabel.text=[textDataArray objectAtIndex:i];
            docLabel.numberOfLines=2;
            docLabel.adjustsFontSizeToFitWidth=YES;
            docLabel.contentScaleFactor=0.8;
            [gridView addSubview:docLabel];
            
            if(counter%3==0 && counter!=0)
            {
                yAxis=yAxis+containerHeight;
                xAxis=0;
                counter=1;
                
            }else{
                xAxis=xAxis+containerWidth;
                counter++;
            }
        }
        
    }
    return self;
}

-(void)closePopUP{
    [self removeFromSuperview];
}

-(void)docTypeBtnAction:(UIButton*)btn{
    [self.delegate selectedDocumentType:[textDataArray objectAtIndex:btn.tag]];
    [self removeFromSuperview];
}

@end
