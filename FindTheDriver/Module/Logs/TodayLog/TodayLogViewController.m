//
//  TodayLogViewController.m
//  FindTheDriver
//
//  Created by Ganesh Korada on 12/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import "TodayLogViewController.h"
#import "TodayLogCustomTableViewCell.h"
#import "TodayLogDetailViewController.h"

@interface TodayLogViewController ()

@property (weak, nonatomic) IBOutlet UIButton *time1Btn;
@property (weak, nonatomic) IBOutlet UIButton *time2Btn;

@end

@implementation TodayLogViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTodayViewComponents];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    GraphView *grapView=[[GraphView alloc]initWithFrame:CGRectMake(0, 60, [[UIScreen mainScreen] bounds].size.width, 140)];
    [self.view addSubview:grapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User defined methods

- (void)loadTodayViewComponents {
    [self setBackBarButtonItem];
    [SCUIUtility setLayerForView:_time1Btn WithColor:kClearColor];
    [SCUIUtility setLayerForView:_time2Btn WithColor:kClearColor];
}

- (IBAction)backBtnClicked:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)scaleTransparentBtnClicked:(id)sender {
    TodayLogDetailViewController *detailVC = [kLogsStoryboard instantiateViewControllerWithIdentifier:@"TodayLogDetailID"];
    [self.navigationController pushViewController:detailVC animated:YES];
//    [self presentViewController:detailVC animated:NO completion:nil];
}

#pragma mark - TableView Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *todayLogCellID = @"TodayLogID";
    
    TodayLogCustomTableViewCell *todayLogCell = (TodayLogCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:todayLogCellID];
    [todayLogCell.statusBtn setTitle:@"SB" forState:UIControlStateNormal];

    NSMutableAttributedString *timeLblMuAtrStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *timeAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"12:00 AM CDT | "] attributes:@{NSFontAttributeName : [UIFont fontWithName:kHelveticaNeueFontName size:16]}];
    NSAttributedString *totalHoursAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"2h 9m"] attributes:@{NSFontAttributeName : [UIFont fontWithName:kHelveticaNeueFontName size:16], NSForegroundColorAttributeName : [UIColor colorFromHexString:@"#3E81D4"]}];

    [timeLblMuAtrStr appendAttributedString:timeAttStr];
    [timeLblMuAtrStr appendAttributedString:totalHoursAttStr];
    
    todayLogCell.timeLbl.attributedText = timeLblMuAtrStr;
    [todayLogCell.locationBtn setTitle:@"Huston,TX" forState:UIControlStateNormal];
    return todayLogCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
