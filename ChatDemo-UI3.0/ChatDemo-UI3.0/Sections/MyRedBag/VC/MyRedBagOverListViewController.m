//
//  MyRedBagOverListViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/13.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRedBagOverListViewController.h"
#import "MyRedBagTool.h"
#import "MyRedBagOverListTableViewCell.h"
#import "MyRedBagOverListModel.h"


@interface MyRedBagOverListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation MyRedBagOverListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self initData];
    [self loadData];

}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _dataSource = array;
    }
    return _dataSource;
}

- (void)setRid:(NSString *)rid{
    _rid = rid;
}

- (void)initData{
    page = 1;
}

- (void)setupUI{
    self.title = @"已抢列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)loadData{
    NSDictionary *param = @{@"uid":User_ID, @"rid":self.rid,@"page":[NSString stringWithFormat:@"%d",page]};
    [MyRedBagTool myRedBagOverListWithParam:param successBlock:^(NSMutableArray *modelArray, NSString *msg, NSNumber *status) {
        if (self->page == 1) {
            [self.dataSource removeAllObjects];
        }
        [self endRefresh];
        
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


-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        tableView.backgroundColor=ColorTableViewBg;
        tableView.tableFooterView = [[UIView alloc] init];
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyRedBagOverListTableViewCell *cell = [MyRedBagOverListTableViewCell normalTableViewCellWithTableView:tableView];
    MyRedBagOverListModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
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
