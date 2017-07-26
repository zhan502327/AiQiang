//
//  DBBillViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBBillViewController.h"
#import "BillModel.h"
#import "BillDetailViewController.h"
#import "DBBillTableViewCell.h"
#import "DBDetailViewController.h"
#import "MyBillTool.h"
@interface DBBillViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _count;
    int page;

}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DBBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    [self setupUI];
    [self loaddata];
    [self tableView];
}

- (void)setupUI{
    self.title = @"我的账单";
    self.view.backgroundColor = [UIColor whiteColor];
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _dataArray = array;
    }
    return _dataArray;
}

- (void)loaddata{
    NSDictionary *param = @{@"uid": User_ID, @"page": [NSString stringWithFormat:@"%d",page]};
    [MyBillTool myBillListWithParam:param successBlock:^(NSString *msg, NSMutableArray *modelArray, NSNumber *status) {
        [self endRefresh];
        if (self->page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:modelArray];
        if (self.dataArray.count == 0) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(100, 200, SCREEN_WIDTH- 200,SCREEN_WIDTH- 200 );
            imageView.image = [UIImage imageNamed:@"wushuju"];
            [self.view addSubview:imageView];
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame), SCREEN_WIDTH, 50);
            label.text = @"暂无数据";
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:18];
            [self.view addSubview:label];
        }else{
            [self.tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        [self endRefresh];
        [self showHint:@"网络错误"];
    }];

}

- (void)endRefresh{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        tableView.backgroundColor=[UIColor clearColor];
        tableView.tableFooterView = [[UIView alloc]init];
        tableView.scrollEnabled=YES;
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self->page = 1;
            [self loaddata];
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self->page ++;
            [self loaddata];
        }];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - tableView delegate and tableView dataSource

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DBBillTableViewCell *cell = [DBBillTableViewCell normalTableViewCellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DBDetailViewController *vc = [[DBDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.billModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
