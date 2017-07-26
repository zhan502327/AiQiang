//
//  MySettingViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MySettingViewController.h"
#import "NormalTableViewCell.h"
#import "ConfigPasswordViewController.h"
#import "UserFeedbackViewController.h"
#import "DBWebViewViewController.h"
#import "DBChatBlackListViewController.h"
#import "DBSMSCodeViewController.h"

@interface MySettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self tableView];
}

- (void)setUI{
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        NSArray *array = @[@"修改登录密码",@"修改支付密码",@"聊天黑名单",@"用户反馈",@"用户协议",@"客服电话"];
        self.dataSource = array;
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        tableView.backgroundColor=ColorTableViewBg;
        
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.scrollEnabled=NO;
        tableView.dataSource=self;
        tableView.delegate=self;
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
    NormalTableViewCell *cell = [NormalTableViewCell normalTableViewCellWithTableView:tableView];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row == 5) {
        
        cell.iconimageView.hidden = YES;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(SCREEN_WIDTH - 200 - 20, 10, 200, 30);
        label.text = @"0371-89930575";
        label.textColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentRight;
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:17];
        [cell.contentView addSubview:label];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.row == 0) {//修改密码
        ConfigPasswordViewController *vc = [[ConfigPasswordViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1) {//修改支付密码
        
        DBSMSCodeViewController *vc = [[DBSMSCodeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    if (indexPath.row == 2) {//黑名单
        DBChatBlackListViewController *vc = [[DBChatBlackListViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.row == 3) {//用户反馈
        UserFeedbackViewController *vc = [[UserFeedbackViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 4) {//用户协议
        
        DBWebViewViewController *vc = [[DBWebViewViewController alloc] init];
        vc.type = @"yong_hu_xie_yi";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
