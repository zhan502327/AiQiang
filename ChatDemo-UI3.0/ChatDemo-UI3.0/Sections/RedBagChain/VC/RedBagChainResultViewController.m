//
//  RedBagChainResultViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/31.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagChainResultViewController.h"
#import "RedBagChainTool.h"
#import "RedBagChainResultListModel.h"
#import "RedBagChainResultModel.h"
#import "RedBagChainResultHeaderView.h"
#import "RedBagChainResultTableViewCell.h"

@interface RedBagChainResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) RedBagChainResultModel *resultModel;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) RedBagChainResultHeaderView *headerView;

@end

@implementation RedBagChainResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
    
}

- (void)setRid:(NSString *)rid{
    _rid = rid;
}

- (RedBagChainResultHeaderView *)headerView{
    if (_headerView == nil) {
        RedBagChainResultHeaderView *view = [RedBagChainResultHeaderView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        _headerView = view;
    }
    return _headerView;
}

- (void)loadData{
    
    NSDictionary *param = @{@"uid":User_ID,@"rid":self.rid};
    [RedBagChainTool redBagLogWithParam:param successBlock:^(NSString *msg, NSNumber *status, RedBagChainResultModel *model) {
        self.resultModel = model;
        self.dataSource = self.resultModel.modelListArray;
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"红包详情";
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        NSArray *array = [NSArray array];
        _dataSource = array;
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.scrollEnabled=YES;
        tableView.dataSource=self;
        tableView.delegate=self;
        RedBagChainResultHeaderView *view = [RedBagChainResultHeaderView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        view.resultModel = self.resultModel;
//        self.headerView.resultModel = self.resultModel;
        tableView.tableHeaderView = view;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RedBagChainResultTableViewCell *cell = [RedBagChainResultTableViewCell normalTableViewCellWithTableView:tableView];
    cell.model = self.dataSource[indexPath.row];
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = ColorTableViewBg;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


@end
