//
//  GraphView.h
//  FindTheDriver
//
//  Created by mac on 19/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UICollectionView *gridCollectionView;
@property(strong,nonatomic)UITableView *gridTimeTableView;
+(GraphView*)sharedComponent;
@end
