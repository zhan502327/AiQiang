//
//  MyCollectionListViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyCollectionListViewController.h"
#import "MyCollectionTool.h"
#import "MyCollectionListTableViewCell.h"
#import "MyCollectionListModel.h"
#import "AllManRedPacketDetailViewController.h"

@interface MyCollectionListViewController ()<UITableViewDelegate,UITableViewDataSource>


{
    int page;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MyCollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self initData];
    [self loadData];
}

- (void)setupUI{
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initData{
    page = 1;
}

- (void)loadData{
    
    NSDictionary *dic = @{@"uid":User_ID,@"page":[NSString stringWithFormat:@"%d",page]};
    [MyCollectionTool mycollectionListWithParam:dic successBlock:^(MyCollectionListResult *result) {
        
        [self endRefresh];
        if (self->page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        if ([result.status isEqualToNumber:@1]) {
            [self.dataSource addObjectsFromArray:result.modelArray];
            [self.tableView reloadData];
        }else{

            [self showHint:result.msg];
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


- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _dataSource = array;
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        tableView.backgroundColor=[UIColor clearColor];
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.scrollEnabled=YES;
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self->page = 1;
            [self loadData];
        }];
        
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self->page ++;
            [self loadData];
        }];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyCollectionListModel *model = self.dataSource[indexPath.row];
    MyCollectionListTableViewCell *cell = [MyCollectionListTableViewCell normalTableViewCellWithTableView:tableView];
    
    cell.model = model;
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
    vc.mycollectionModel = self.dataSource[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
