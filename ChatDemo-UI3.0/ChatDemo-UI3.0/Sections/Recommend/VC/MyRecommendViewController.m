//
//  MyRecommendViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRecommendViewController.h"
#import "MineTool.h"
#import "MyRecommendListModel.h"
#import "MyRecommendTableViewCell.h"

@interface MyRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    int page;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *code;

@end

@implementation MyRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    
    [self configUI];
    
    [self loadData];
}

- (void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"推荐的人";
    
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}

- (void)loadData{
    
    NSDictionary *param = @{@"uid":User_ID, @"page":[NSString stringWithFormat:@"%d",page]};
    [MineTool getRecommendListWithParam:param successBlock:^(NSMutableArray *modelArray, NSString *msg, NSNumber *status ,NSString *code) {
        
        [self endRefresh];
        if (self->page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:modelArray];
        self.code = code;
        [self.tableView reloadData];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(100, 200, SCREEN_WIDTH- 200,SCREEN_WIDTH- 200 );
        imageView.hidden = YES;
        imageView.image = [UIImage imageNamed:@"wushuju"];
        [self.view addSubview:imageView];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame), SCREEN_WIDTH, 50);
        label.text = @"暂无数据";
        label.textColor = [UIColor grayColor];
        label.hidden = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18];
        [self.view addSubview:label];
        if (self.dataSource.count == 0) {
            imageView.hidden = NO;
            label.hidden = NO;
        }else{
            imageView.hidden = YES;
            label.hidden = YES;
        }
    } errorBlock:^(NSError *error) {
        [self endRefresh];
        [self showHint:@"网络错误"];
    }];
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        tableView.backgroundColor=ColorTableViewBg;
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
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyRecommendListModel *model = self.dataSource[indexPath.row];
    MyRecommendTableViewCell *cell = [MyRecommendTableViewCell normalTableViewCellWithTableView:tableView];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    view.backgroundColor = ColorTableViewBg;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = ColorTableViewBg;
    label.frame = CGRectMake(10, 10, SCREEN_WIDTH - 30, 30);
    label.text = [NSString stringWithFormat:@"我的推荐码：%@",self.code];
    label.font = DBMaxFont;
    label.textColor = DBBlackColor;
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


@end
