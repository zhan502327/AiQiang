//
//  MyReplyViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyReplyViewController.h"
#import "MyReplyTableViewCell.h"
#import "MyDiscoverTool.h"
#import "MyReplyModel.h"
#import "CircleDetailViewController.h"
#import "OtherPersonInfoViewController.h"

@interface MyReplyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation MyReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    [self setupUI];
    [self loadData];
    
}

- (void)loadData{
    NSDictionary *param = @{@"uid":User_ID, @"page":[NSString stringWithFormat:@"%d",page]};
    [MyDiscoverTool relateMeWithParam:param successBlock:^(NSMutableArray *modelArray, NSString *msg, NSNumber *status) {
        [self endRefresh];
        
        if (self->page == 1) {
            [self.dataSource removeAllObjects];
            
        }
        
        [self.dataSource addObjectsFromArray:modelArray];
        if (self.dataSource.count == 0) {
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

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"与我相关";
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self->page = 1;
            [self loadData];
        }];
        
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self->page ++;
            [self loadData];
        }];
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}
#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyReplyModel *model = self.dataSource[indexPath.section];
    return 190 + model.contentLabelHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyReplyModel *model = self.dataSource[indexPath.section];
    MyReplyTableViewCell *cell = [MyReplyTableViewCell normalTableViewCellWithTableView:tableView];
    cell.model = model;
    
    //头像点击
    [cell setIconImageViewBlock:^{
        OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.uid = model.uid;
        [self.navigationController pushViewController:vc animated:YES];

    }];
    
    //查看动态详细
    [cell setDetailBlock:^{
        CircleDetailViewController *vc = [[CircleDetailViewController alloc] init];
        vc.cid = model.cid;
        [vc setDeleteDiscoverReloadDataBlock:^{
            [self loadData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}



@end
