//
//  MyRedBagListViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRedBagListViewController.h"
#import "MyRedBagListTableViewCell.h"
#import "MyRedBagTool.h"
#import "MyRedBagListModel.h"
#import "AllManRedPacketDetailViewController.h"
#import "MyRedBagOverListViewController.h"
#import "MyRedBagPublishRedBagViewController.h"

@interface MyRedBagListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation MyRedBagListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    [self setUI];
    [self loadData];
}

- (void)setUI{
    self.title = @"我的红包";
    self.view.backgroundColor =[UIColor whiteColor];
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
        tableView.backgroundColor=[UIColor whiteColor];
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

- (void)loadData{
    
    NSDictionary *dic = @{@"uid":User_ID,@"page":[NSString stringWithFormat:@"%d",page]};
    [MyRedBagTool myRedBagListWithParam:dic successBlock:^(MyRedBagListResult *result) {
        [self endFresh];
        if (self->page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:result.modelArray];
        
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
        [self endFresh];

        [self showHint:@"网络错误"];
    }];
}

- (void)endFresh{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}



#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyRedBagListTableViewCell *cell = [MyRedBagListTableViewCell normalTableViewCellWithTableView:tableView];
    MyRedBagListModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    
    [cell setLeftButtonBlock:^{
        NSLog(@"leftbutton");
        MyRedBagOverListViewController *vc = [[MyRedBagOverListViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.rid = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [cell setRightButtonBlock:^{
        NSLog(@"rightbutton");
        MyRedBagPublishRedBagViewController *vc = [[MyRedBagPublishRedBagViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.rid = model.ID;
        [vc setRefreshDataBlock:^{
         
            [self.tableView.mj_header beginRefreshing];
        }];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
    vc.myRedBagModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
