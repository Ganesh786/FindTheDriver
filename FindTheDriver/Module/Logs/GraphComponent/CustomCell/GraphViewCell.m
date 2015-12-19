//
//  GraphViewCell.m
//  FindTheDriver
//
//  Created by mac on 19/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "GraphViewCell.h"
#import "GraphConstants.h"

@implementation GraphViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *gridView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, GRID_BOX_WT, GRID_BOX_HT)];
        gridView.backgroundColor=kClearColor;
        [self.contentView addSubview:gridView];

        [self gridViewLayout:gridView width:gridView.frame.size.width ht:gridView.frame.size.height];
        
        //Top Border
        CALayer *topBorder=[CALayer layer];
        topBorder.frame=CGRectMake(0, 0, GRID_BOX_WT, 2);
        topBorder.backgroundColor=kLightGrayColor.CGColor;
        [gridView.layer addSublayer:topBorder];
        
        //Right Top Border
        self.rightTopBorder=[CALayer layer];
        self.rightTopBorder.frame=CGRectMake(GRID_BOX_WT-1, 0, 2, GRID_BOX_HT/2);
        self.rightTopBorder.backgroundColor=kLightGrayColor.CGColor;
        [gridView.layer addSublayer:self.rightTopBorder];
        
        //Right Bottom Border
        self.rightBottomBorder=[CALayer layer];
        self.rightBottomBorder.frame=CGRectMake(GRID_BOX_WT-1, GRID_BOX_HT/2, 2, GRID_BOX_HT/2);
        self.rightBottomBorder.backgroundColor=kGreenColor.CGColor;
        [gridView.layer addSublayer:self.rightBottomBorder];
        
        //Grid Horizontal View
        self.gridHorView=[[UIView alloc]initWithFrame:CGRectMake(0, GRID_BOX_HT/3, GRID_BOX_WT, GRID_BOX_HT/3)];
        self.gridHorView.backgroundColor=kClearColor;
        [gridView addSubview:self.gridHorView];
    }
    return self;
}

-(void)gridViewLayout:(UIView*)gridView width:(CGFloat)gridWidth ht:(CGFloat)ht{
    CGFloat width=gridWidth/3;
    for (int i=0; i<3; i++) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(i*width+(width/2), 0, width/2-1, ht)];
        lineView.backgroundColor=kClearColor;
        CALayer *bottomBorder=[CALayer layer];
        bottomBorder.frame=CGRectMake(0, lineView.frame.size.height, 1, -((lineView.frame.size.height/2)/(i%2?2:3)));
        bottomBorder.backgroundColor=kLightGrayColor.CGColor;
        [lineView.layer addSublayer:bottomBorder];
        [gridView addSubview:lineView];
    }
}

@end
