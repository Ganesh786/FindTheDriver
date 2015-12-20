//
//  TodayLogDetailViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 17/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "TodayLogDetailViewController.h"
#import "TodayLogDetailCustomTableViewCell.h"
#import "TodayLogDetailStatusTableViewCell.h"

@interface TodayLogDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *logDetailTableView;

@property (weak, nonatomic) IBOutlet UIView *topGraphView;
@property(nonatomic,strong)GraphView *graphComponent;
@end

@implementation TodayLogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpView];
}

-(void)setUpView{
    self.graphComponent=[GraphView sharedComponent];
    [self.topGraphView addSubview:self.graphComponent];
    
    self.logDetailTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.logDetailTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.navigationItem.title=@"Monday | 10 Oct 2015";
    self.tabBarController.tabBar.hidden=YES;
}

- (IBAction)SaveChangesBtnAction:(id)sender {
    
}

- (IBAction)InsertPastDutyStatusBtnAction:(id)sender {
    
}

#pragma mark:-UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        return 60;
    }
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *detailCustomCellIdentifier=@"TodayLogDetailCustomTableViewCell";
    static NSString *logDetailStatusCellIdentifier=@"TodayLogDetailStatusTableViewCell";
    if (indexPath.row % 2 == 0) {
        TodayLogDetailCustomTableViewCell *logDetailCell=[tableView dequeueReusableCellWithIdentifier:detailCustomCellIdentifier forIndexPath:indexPath];
        return logDetailCell;
    }else{
       
        TodayLogDetailStatusTableViewCell *logStatusCell=[tableView dequeueReusableCellWithIdentifier:logDetailStatusCellIdentifier forIndexPath:indexPath];
        return logStatusCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
