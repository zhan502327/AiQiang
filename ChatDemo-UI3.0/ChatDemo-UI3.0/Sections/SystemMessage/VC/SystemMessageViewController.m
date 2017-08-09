
//
//  SystemMessageViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "SystemMessageViewController.h"
#import "SystemMessageTool.h"
#import "SystemMessageListTableViewCell.h"
#import "SystemMessageListModel.h"
#import "RedPacketChatViewController.h"
#import "MineTool.h"
@interface SystemMessageViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    int page;
}

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation SystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    page = 1;
    [self loadData];
    
}

- (void)setupUI{
    self.title = @"系统消息";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)loadData{
    NSDictionary *param = @{@"uid":User_ID, @"page":[NSString stringWithFormat:@"%d",page]};
    [SystemMessageTool systemMessageListWithParam:param successBlock:^(NSMutableArray *array, NSNumber *status, NSString *msg) {
        [self endRefresh];
        if (self->page == 1) {
         
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:array];
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
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        tableView.backgroundColor=[UIColor clearColor];
        tableView.scrollEnabled=YES;
        tableView.tableFooterView = [[UIView alloc] init];
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
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SystemMessageListModel *model = self.dataSource[indexPath.row];
    SystemMessageListTableViewCell *cell = [SystemMessageListTableViewCell normalTableViewCellWithTableView:tableView];
    cell.model = model;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SystemMessageListModel *model = self.dataSource[indexPath.row];
    
    NSData *jsonData = [model.ext dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    NSString *uid = [NSString stringWithFormat:@"%@",dic[@"uid"]];
    
    
    NSDictionary *param = @{@"uid":User_ID,@"get_uid":uid};
    
    [MineTool userInfoWithSuccessBlockWithPram:param successBlock:^(UserInfoModel *infomodel) {
        UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
        chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:uid conversationType:EMConversationTypeChat];
#else
        chatController = [[ChatViewController alloc] initWithConversationChatter:uid  conversationType:EMConversationTypeChat];
#endif
        chatController.title = infomodel.nickname;
        chatController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:YES];
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


@end
