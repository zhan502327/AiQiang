//
//  MyAccountViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/15.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MyAccountHeaderView.h"
#import "MyAccountTableViewCell.h"
#import "MoneyMangerViewController.h"
#import "MyAccountTiXianListViewController.h"
#import "TiXianViewController.h"
#import "DBBillViewController.h"

@interface MyAccountViewController ()<UITableViewDelegate,UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setupUI];
    [self tableView];
}


- (void)initData{
}
- (void)viewWillAppear:(BOOL)animated{
    [self.view endEditing:YES];
}
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"明细" style:UIBarButtonItemStyleDone target:self action:@selector(itemClicked)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)itemClicked{
    DBBillViewController *vc = [[DBBillViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setMyAccount:(NSString *)myAccount{
    _myAccount = myAccount;
}

- (void)setMyAccountType:(NSString *)myAccountType{
    _myAccountType = myAccountType;
    if ([myAccountType isEqualToString:@"rmb"]) {//现金余额
        self.title = @"现金余额";
        
        self.dataSource = @[@"充值",@"提现",@"提现记录"];
    }else{
        self.title = @"红包余额";
        self.dataSource = @[@"提现到现金余额",@"提现记录"];
    }
}



- (NSArray *)imageArray{
    if (_imageArray == nil) {
        NSArray *array = @[@"zhongzhitixian",@"zhongzhitixian",@"zhongzhitixian"];
        _imageArray = array;
    }
    return _imageArray;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        tableView.backgroundColor = ColorTableViewBg;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        MyAccountHeaderView *view = [MyAccountHeaderView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        view.accountLabel .text = [NSString stringWithFormat:@"¥%@",self.myAccount];
        [view setLeftButtonBlock:^{
            MoneyMangerViewController *vc = [[MoneyMangerViewController alloc] init];
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [view setRightButtonBlock:^{
            MoneyMangerViewController *vc = [[MoneyMangerViewController alloc] init];
            vc.type = 2;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        tableView.tableHeaderView = view;
        
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
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAccountTableViewCell *cell = [MyAccountTableViewCell normalTableViewCellWithTableView:tableView];
    cell.iconimageView.image = [UIImage imageNamed:self.imageArray[indexPath.section]];

    cell.nameLabel.text = self.dataSource[indexPath.section];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([self.myAccountType isEqualToString:@"rmb"]) {//现金余额
        if (indexPath.section == 0 || indexPath.section == 1) {
            MoneyMangerViewController *vc = [[MoneyMangerViewController alloc] init];
            vc.type = (int)indexPath.section + 1;//1--充值   2--提现
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.section == 2) {
            
            MyAccountTiXianListViewController *vc = [[MyAccountTiXianListViewController alloc] init];
            vc.type = @"r";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }

        
    }else{
        if (indexPath.section == 0) {//提现到现金余额
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"红包余额不能充值，提现到现金余额将不能返回，" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            
            
        }
        
        if (indexPath.section == 1) {
            MyAccountTiXianListViewController *vc = [[MyAccountTiXianListViewController alloc] init];
            vc.type = @"b";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"提现到现金余额");
    TiXianViewController *vc = [[TiXianViewController alloc] init];
    vc.type = 3;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = ColorTableViewBg;
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor grayColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}



@end
