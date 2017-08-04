//
//  DBMineViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBMineViewController.h"
#import "MineHeaderView.h"
#import "MineFirstTableViewCell.h"
#import "MineSecondTableViewCell.h"
#import "MyCollectionListViewController.h"
#import "MyRedBagListViewController.h"
#import "PersonalInformationViewController.h"
#import "MineTool.h"
#import "UserInfoModel.h"
#import "MyAccountViewController.h"
#import "ApplyViewController.h"
#import "DBBillViewController.h"
#import "MyDiscoverViewController.h"
#import "MySettingViewController.h"
#import "RecommendViewController.h"
#import "PersonalInfoViewController.h"
#import "SystemMessageViewController.h"
#import "DBWebViewViewController.h"
#import "DBShareView.h"
#import "MyRecommendViewController.h"

@interface DBMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) MineHeaderView *headerview;
@property (nonatomic, strong) UserInfoModel *userModel;

@property (nonatomic, copy) NSString *rmb;//现金余额
@property (nonatomic, copy) NSString *balance;//红包余额

@property (nonatomic, weak) UIView *blackview;
@property (nonatomic, weak) DBShareView *shareView;

@property (nonatomic, assign) BOOL isShowCircleRedView;
@property (nonatomic, assign) BOOL isShowSysMsgRedView;

@end

@implementation DBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isShowCircleRedView = NO;
    self.isShowSysMsgRedView = NO;
    
    [self setUI];
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSysMsgOrCiecleRedView:) name:@"ShowSysMsgOrCiecleRedView" object:nil];
    [self loadData];
    
    
}

- (void)showSysMsgOrCiecleRedView:(NSNotification *)center{
    //    {
    //        isShow = 1;
    //        type = sysmsg;
    //    }
    NSDictionary *dic = center.object;
    NSString *type = dic[@"type"];
    NSString *isShow = dic[@"isShow"];

    if ([type isEqualToString:@"sysmsg"]) {
        if ([isShow isEqualToString:@"1"]) {
            self.isShowSysMsgRedView = YES;
        }else{
            self.isShowSysMsgRedView = NO;
        }
    }
    
    
    if ([type isEqualToString:@"circle"]) {
        if ([isShow isEqualToString:@"1"]) {
            self.isShowCircleRedView = YES;
        }else{
            self.isShowCircleRedView = NO;
        }
    }
    
    [self.tableView reloadData];
  
}

- (void)setUI{
    self.title = @"我 的";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (UIView *)blackview{
    if (_blackview == nil) {
        UIView *view = [[UIView alloc] init];
        view.userInteractionEnabled = YES;
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackViwClicked)];
        [view addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        _blackview = view;
    }
    return _blackview;
}
- (DBShareView *)shareView{
    if (_shareView == nil) {
        DBShareView *shareViw = [DBShareView viewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 120, SCREEN_HEIGHT, 120)];
        [[UIApplication sharedApplication].keyWindow addSubview:shareViw];
        _shareView = shareViw;
    }
    return _shareView;
}


- (void)blackViwClicked{
    [self.view endEditing:YES];
    [self.blackview removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (void)loadData{

    NSDictionary *dic = @{@"uid":User_ID,@"get_uid":User_ID};

    [MineTool userInfoWithSuccessBlockWithPram:dic successBlock:^(UserInfoModel *model) {
        self.userModel = model;
        self.headerview.userModel = model;
        [self.tableView reloadData];


    } errorBlock:^(NSError *error) {

        [self showHint:@"网络错误"];

    }];
    
    [MineTool userMoneyWithSuccessBlockWithPram:dic successBlock:^(NSString *rmb, NSString *balance) {

        self.rmb = rmb;
        self.balance = balance;
        
    } errorBlock:^(NSError *error) {

        [self showHint:@"网络错误"];
    }];

    
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        NSArray *array = nil;
        if ([User_is_recommend isEqualToString:@"1"]) {
            array = @[@[@""],@[@"现金余额",@"红包余额",@"我的账单"],@[@"我要推荐",@"推荐的人",@"系统消息"],@[@"查询帮助",@"设置"]];
        }else{
            array = @[@[@""],@[@"现金余额",@"红包余额",@"我的账单"],@[@"我要推荐",@"系统消息"],@[@"查询帮助",@"设置"]];
        }
        _dataSource = array;
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40) style:UITableViewStyleGrouped];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40);
        tableView.backgroundColor = ColorTableViewBg;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        self.headerview = [MineHeaderView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        self.headerview.userModel = self.userModel;
        self.headerview.hiddenSettingButton = YES;
        typeof(self) weakself = self;
        [self.headerview setIconImageViewBlock:^{
            PersonalInfoViewController *vc = [[PersonalInfoViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
        
        [self.headerview setSettingButtonBlock:^{
    
            
        }];
        
        
        tableView.tableHeaderView = self.headerview;
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
    return [self.dataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }else{
        return DBCellHeight;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MineFirstTableViewCell *cell = [MineFirstTableViewCell normalTableViewCellWithTableView:tableView];
        
        cell.redView.hidden = !self.isShowCircleRedView;
        [cell setFirstButtonBlock:^{
            MyCollectionListViewController *vc=[[MyCollectionListViewController alloc]init];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [cell setSecondButtonBlock:^{
            MyRedBagListViewController *vc=[[MyRedBagListViewController alloc]init];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [cell setThirdButtonBlock:^{
            NSDictionary *object = @{@"type" : @"circle", @"isShow" : @"0"};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSysMsgOrCiecleRedView" object:object];
            
            MyDiscoverViewController *vc = [[MyDiscoverViewController alloc] init];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }else{
        MineSecondTableViewCell *cell = [MineSecondTableViewCell normalTableViewCellWithTableView:tableView];
        cell.nameLabel.text = self.dataSource[indexPath.section][indexPath.row];
        
        
      
        if ([User_is_recommend isEqualToString:@"1"]) {
            if (indexPath.section == 2 && indexPath.row == 2) {
                cell.redView.hidden = !self.isShowSysMsgRedView;
            }else{
                cell.redView.hidden = YES;
            }

        }else{
            
            if (indexPath.section == 2 && indexPath.row == 1) {
                cell.redView.hidden = !self.isShowSysMsgRedView;
            }else{
                cell.redView.hidden = YES;
            }

            
        }
        
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==   1) {
        if (indexPath.row == 0) {//现金余额
            MyAccountViewController *vc = [[MyAccountViewController alloc] init];
            vc.myAccount = self.rmb;
            vc.myAccountType = @"rmb";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.row == 1) {//红包余额
            MyAccountViewController *vc = [[MyAccountViewController alloc] init];
            vc.myAccount = self.balance;
            vc.myAccountType = @"balance";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.row == 2) {//我的账单
            DBBillViewController *vc = [[DBBillViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {//我要推荐
//            RecommendViewController *vc = [[RecommendViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
            
            [self blackview];
            [self shareView];
            
        }
        
        if (indexPath.row == 1) {//推荐的人
            
  
            if ([User_is_recommend isEqualToString:@"1"]) {//推荐的人
                MyRecommendViewController *vc = [[MyRecommendViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];

            }else{//系统消息
                NSDictionary *object = @{@"type" : @"sysmsg", @"isShow" : @"0"};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSysMsgOrCiecleRedView" object:object];
                SystemMessageViewController *vc = [[SystemMessageViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
        if (indexPath.row == 2) {//系统消息
            
            NSDictionary *object = @{@"type" : @"sysmsg", @"isShow" : @"0"};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSysMsgOrCiecleRedView" object:object];
            
            
            SystemMessageViewController *vc = [[SystemMessageViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            DBWebViewViewController *vc = [[DBWebViewViewController alloc] init];
            vc.type = @"cha_xun_bang_zhu";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.row == 1) {//设置
            MySettingViewController *vc = [[MySettingViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        return view;
    }
    
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.000001;
    }
    
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(20, 10, SCREEN_WIDTH - 40, 40);
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = UIColorFromRGB(@"d9343c");
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(loginOutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    [backView addSubview:button];
    if (section == 3) {
        return backView;
    }else{
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 80;
    }else{
        return 0.00000001;
    }
}
- (void)loginOutButtonClick{
    __weak DBMineViewController *weakSelf = self;
    
    [self showHudInView:self.view hint:@"退出登录中"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (error != nil) {
                [weakSelf showHint:error.errorDescription];
            }
            else{
                [[ApplyViewController shareController] clear];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        });
    });
    
}
@end
