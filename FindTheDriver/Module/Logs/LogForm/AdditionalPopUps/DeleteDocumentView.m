//
//  DeleteDocumentView.m
//  FindTheDriver
//
//  Created by mac on 24/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "DeleteDocumentView.h"

@implementation DeleteDocumentView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor colorWithRed:0.200f green:0.200f blue:0.200f alpha:0.5f];
        
        UIView *popUp=[[UIView alloc]initWithFrame:CGRectMake(10, (frame.size.height-250)/2, frame.size.width-20, 250)];
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
        headerLabel.text=@"DELETE DOCUMENT";
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
        
        UILabel *docLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,30, containerView.frame.size.width-20, 60)];
        docLabel.textColor=kGrayColor;
        docLabel.textAlignment=NSTextAlignmentCenter;
        docLabel.backgroundColor=kClearColor;
        docLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
        docLabel.text=@"Are you sure you want to delete this document from your log?";
        docLabel.numberOfLines=10;
        docLabel.adjustsFontSizeToFitWidth=YES;
        docLabel.contentScaleFactor=0.8;
        [containerView addSubview:docLabel];
        
        UIButton *docBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        docBtn.frame=CGRectMake((containerView.frame.size.width-200)/2, docLabel.frame.origin.y+docLabel.frame.size.height+30, 200, 40);
        [docBtn addTarget:self action:@selector(documentDeleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [docBtn setTitle:@"CONFIRM" forState:UIControlStateNormal];
        [docBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [docBtn setBackgroundColor:kNavBarColor];
        docBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        docBtn.layer.cornerRadius=5.0f;
        docBtn.layer.masksToBounds=YES;
        [containerView addSubview:docBtn];
        
    }
    return self;
}

-(void)closePopUP{
    [self.delegate deleteDocumentCancelled];
    [self removeFromSuperview];
}

-(void)documentDeleteBtnAction{
    [self.delegate deleteDocumentConfirmed];
    [self removeFromSuperview];
}

@end
