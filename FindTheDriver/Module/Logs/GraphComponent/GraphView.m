//
//  GraphView.m
//  FindTheDriver
//
//  Created by mac on 19/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "GraphView.h"
#import "GraphViewCell.h"
#import "GraphConstants.h"
#import "GridTimerViewCell.h"
#import "GraphDataClass.h"

@implementation GraphView

+(GraphView*)sharedComponent{
    static GraphView *sharedComponent=nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedComponent=[[GraphView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    });
    return sharedComponent;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, GRAPH_VIEW_HT)];
        bgView.backgroundColor=kClearColor;
        CALayer *bottomBorder=[CALayer layer];
        bottomBorder.frame=CGRectMake(0, bgView.frame.size.height, bgView.frame.size.width, 2);
        bottomBorder.backgroundColor=kLightGrayColor.CGColor;
        [bgView.layer addSublayer:bottomBorder];
        [self addSubview:bgView];
        
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(GRID_LEFTVIEW_WT, 0, [[UIScreen mainScreen]bounds].size.width-(GRID_LEFTVIEW_WT+GRID_RIGHTVIEW_WT), GRID_TOPVIEW_HT)];
        topView.backgroundColor=kClearColor;
        
        UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, GRID_TOPVIEW_HT, GRID_LEFTVIEW_WT, GRAPH_VIEW_HT-GRID_TOPVIEW_HT)];
        leftView.backgroundColor=kNavBarColor;
        
        self.gridTimeTableView=[[UITableView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-(GRID_RIGHTVIEW_WT)), GRID_TOPVIEW_HT, GRID_RIGHTVIEW_WT, GRAPH_VIEW_HT-GRID_TOPVIEW_HT) style:UITableViewStylePlain];
        self.gridTimeTableView.delegate=self;
        self.gridTimeTableView.dataSource=self;
        [self.gridTimeTableView setBackgroundColor:kNavBarColor];
        [self.gridTimeTableView setSeparatorColor:kClearColor];
        self.gridTimeTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.gridTimeTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(GRID_BOX_WT, GRID_BOX_HT)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing=0;
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        self.gridCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(GRID_LEFTVIEW_WT,GRID_TOPVIEW_HT, [[UIScreen mainScreen]bounds].size.width-(GRID_LEFTVIEW_WT+GRID_RIGHTVIEW_WT), GRAPH_VIEW_HT-GRID_TOPVIEW_HT) collectionViewLayout:flowLayout];
        [self.gridCollectionView registerClass:[GraphViewCell class] forCellWithReuseIdentifier:@"GraphViewCell"];
        self.gridCollectionView.delegate=self;
        self.gridCollectionView.dataSource=self;
        self.gridCollectionView.bounces=YES;
        [self.gridCollectionView setBackgroundColor:kClearColor];
        
        [bgView addSubview:topView];
        [bgView addSubview:leftView];
        [bgView addSubview:self.gridTimeTableView];
        [bgView addSubview:self.gridCollectionView];
        
        [self topViewContent:topView width:GRID_BOX_WT];
        [self leftViewContent:leftView ht:GRID_BOX_HT];
    }
    return self;
}

#pragma mark:- UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [GraphDataClass graphSections].count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 24;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"GraphViewCell";
    GraphViewCell *cell =(GraphViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.rightBottomBorder.backgroundColor=kLightGrayColor.CGColor;
    cell.rightTopBorder.backgroundColor=kLightGrayColor.CGColor;
//    cell.gridHorView.backgroundColor=indexPath.row%4?kNavBarColor:kClearColor;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DEBUGLOG(@"Selected indexPath.row ->%ld",indexPath.row);
}


#pragma mark:-UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"GridTimerViewCell";
    GridTimerViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == Cell) {
        Cell =[[GridTimerViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Cell.backgroundColor=kClearColor;
    Cell.timerLabel.text=@"07.00";
    return Cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return GRID_BOX_HT;
}

//Top timings
-(void)topViewContent:(UIView*)topView width:(CGFloat)gridWidth{
    for (int i=0; i<26; i=i+2) {
        UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*gridWidth, 5, gridWidth, 15)];
        timeLabel.text=[NSString stringWithFormat:@"%d",i];
        timeLabel.textAlignment=NSTextAlignmentLeft;
        timeLabel.textColor=kBlackColor;
        timeLabel.numberOfLines=1;
        timeLabel.font=[UIFont fontWithName:kHelveticaNeueFontName size:12];
        timeLabel.adjustsFontSizeToFitWidth=YES;
        timeLabel.contentScaleFactor=0.8;
        [topView addSubview:timeLabel];
    }
}

//Left Indicator labels
-(void)leftViewContent:(UIView*)leftView ht:(CGFloat)gridHt{
    NSArray *array=[NSArray arrayWithObjects:@"OFF",@"SB",@"D",@"ON", nil];
    for (int i=0; i<4; i++) {
        UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, i*gridHt+5, leftView.frame.size.width-2, 20)];
        timeLabel.text=[array objectAtIndex:i];
        timeLabel.textAlignment=NSTextAlignmentRight;
        timeLabel.textColor=kBlackColor;
        timeLabel.numberOfLines=1;
        timeLabel.font=[UIFont fontWithName:kHelveticaNeueFontName size:14];
        timeLabel.adjustsFontSizeToFitWidth=YES;
        timeLabel.contentScaleFactor=0.8;
        [leftView addSubview:timeLabel];
    }
}
@end
